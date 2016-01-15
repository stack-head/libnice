
#include <config.h>
#define NO_IMPORT_PYGOBJECT
#include <pygobject.h>
#include "../agent/agent.h"
#include "../agent/candidate.h"

void libnice_register_classes (PyObject *d); 
extern PyMethodDef libnice_functions[];
 
DL_EXPORT(void)
initlibnice(void)
{
    PyObject *m, *d;
 
    init_pygobject ();
 
    m = Py_InitModule ("libnice", libnice_functions);
    d = PyModule_GetDict (m);
 
    libnice_register_classes (d);
 
    if (PyErr_Occurred ()) {
        Py_FatalError ("can't initialise module libnice");
    }
}

DL_EXPORT(GType)
nice_candidate_get_type (void)
{
    static GType candidate_type = 0;
    if (candidate_type == 0)
    {
        candidate_type = g_boxed_type_register_static (
                                                       "NiceCandidate",
                                                       (GBoxedCopyFunc)nice_candidate_copy,
                                                       (GBoxedFreeFunc)nice_candidate_free);
    }
    
    return candidate_type;
}