#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

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

void set_row_names(SEXP vec, SEXP val) {
  SEXP attrib_vec = ATTRIB(vec);
  SEXP attrib_cell = Rf_cons(val, attrib_vec);
  SET_TAG(attrib_cell, R_RowNamesSymbol);
  SET_ATTRIB(vec, attrib_cell);
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
