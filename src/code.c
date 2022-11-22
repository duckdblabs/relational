#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <Rdefines.h>
#include <R_ext/Altrep.h>

static R_altrep_class_t chunkrep_integer_class;

static SEXP chunkrep_wrap(SEXP x) {
  if (!IS_INTEGER(x)) {
    error("need integer vectors");
  }
  SEXP ans = R_new_altrep(chunkrep_integer_class, x, R_NilValue);
  MARK_NOT_MUTABLE(ans);
  return ans;
}

static Rboolean chunkrep_inspect(SEXP x, int pre, int deep, int pvec,
                                 void (*inspect_subtree)(SEXP, int, int, int)) {

  Rprintf("CHUNKREP \n");
  inspect_subtree(R_altrep_data1(x), pre, deep, pvec);
  return TRUE;
}


static R_xlen_t chunkrep_length(SEXP x) {
  return LENGTH(R_altrep_data1(x));
}


static void* chunkrep_dataptr(SEXP x, Rboolean writeable) {
  if (R_altrep_data2(x) == R_NilValue) {
    Rprintf("⚠️ DATAPTR()\n");
    Rf_PrintValue(R_altrep_data1(x));
    R_set_altrep_data2(x, R_RowNamesSymbol);
  }
  return DATAPTR(R_altrep_data1(x));
}


//LISTSXP
//Pointers to the CAR, CDR (usually a LISTSXP or NULL) and TAG (a SYMSXP or NULL).

// https://github.com/hadley/r-internals/blob/master/pairlists.md


void set_row_names(SEXP vec, SEXP val) {
  SEXP attrib_vec = ATTRIB(vec);
  SEXP attrib_cell = Rf_cons(val, attrib_vec);
  SET_TAG(attrib_cell, R_RowNamesSymbol);
  SET_ATTRIB(vec, attrib_cell);
}

// mostly installAttrib from attrib.c
static void set_attrib(SEXP s, SEXP name, SEXP val) {
    SEXP last_attrib = R_NilValue;
    for (SEXP attrib = ATTRIB(s); attrib != R_NilValue; attrib = CDR(attrib)) {
        last_attrib = attrib;
    }
    SEXP new_attrib = PROTECT(Rf_cons(val, R_NilValue));
    SET_TAG(new_attrib, name);
    if (ATTRIB(s) == R_NilValue) {
        SET_ATTRIB(s, new_attrib);
    } else  {
        SETCDR(last_attrib, new_attrib);
    }
    UNPROTECT(1);
}

static void copy_df_attribs(SEXP template, SEXP result) {
    if (result == R_NilValue || result == R_NilValue) {
        Rf_error("Need non-NULL parameters");
    }

    // get existing names and row names
    SEXP names = Rf_getAttrib(result, R_NamesSymbol);
    SEXP row_names = Rf_getAttrib(result, R_RowNamesSymbol);

    // clear all attributes on target
    SET_ATTRIB(result, R_NilValue);

    // restore names and row names
    if (names != R_NilValue) {
        set_attrib(result, R_NamesSymbol, names);
    }
    if (row_names != R_NilValue) {
        set_attrib(result, R_RowNamesSymbol, row_names);
    }

    // add attributes from template that are *not* names or row.names
    for (SEXP attrib = ATTRIB(template); attrib != R_NilValue; attrib = CDR(attrib)) {
        if (TAG(attrib) == R_NamesSymbol ||
            TAG(attrib) == R_RowNamesSymbol) {
            continue;
        }
        set_attrib(result, TAG(attrib), CAR(attrib));
    }
}

static SEXP promise(SEXP f) {
    SEXP prom = PROTECT(Rf_allocSExp(PROMSXP));
    SET_PRENV(prom, R_EmptyEnv);
    SET_PRCODE(prom, Rf_lang1(f));
    SET_PRVALUE(prom, R_UnboundValue);
    UNPROTECT(1);
    return prom;
}

static SEXP is_promise(SEXP p) {
    return Rf_ScalarLogical(TYPEOF(p) == PROMSXP);
}


#define CALLDEF(name, n)  {#name, (DL_FUNC) &name, n}
static const R_CallMethodDef R_CallDef[] = {
  CALLDEF(chunkrep_wrap, 1),
  CALLDEF(promise, 1),
  CALLDEF(is_promise, 1),
  CALLDEF(copy_df_attribs, 2),

  CALLDEF(set_row_names, 2),
  {NULL, NULL, 0}
};


void R_init_relational(DllInfo *dll) {
  R_altrep_class_t cls = R_make_altinteger_class("wrap_integer", "relational", dll);

  R_set_altrep_Inspect_method         (cls, chunkrep_inspect);
  R_set_altrep_Length_method          (cls, chunkrep_length);
  R_set_altvec_Dataptr_method         (cls, chunkrep_dataptr);

  chunkrep_integer_class = cls;

  R_registerRoutines(dll, NULL, R_CallDef, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
