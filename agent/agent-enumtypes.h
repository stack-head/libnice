


#ifndef __AGENT_ENUM_TYPES_H__
#define __AGENT_ENUM_TYPES_H__

#include <glib-object.h>

G_BEGIN_DECLS

/* enumerations from "/pexip/external/gstreamer/0.10/libnice/agent/agent.h" */
GType nice_component_state_get_type (void);
#define NICE_TYPE_COMPONENT_STATE (nice_component_state_get_type())
GType nice_component_type_get_type (void);
#define NICE_TYPE_COMPONENT_TYPE (nice_component_type_get_type())
GType nice_compatibility_get_type (void);
#define NICE_TYPE_COMPATIBILITY (nice_compatibility_get_type())
GType nice_proxy_type_get_type (void);
#define NICE_TYPE_PROXY_TYPE (nice_proxy_type_get_type())

/* enumerations from "/pexip/external/gstreamer/0.10/libnice/agent/candidate.h" */
GType nice_candidate_type_get_type (void);
#define NICE_TYPE_CANDIDATE_TYPE (nice_candidate_type_get_type())
GType nice_candidate_transport_get_type (void);
#define NICE_TYPE_CANDIDATE_TRANSPORT (nice_candidate_transport_get_type())
GType nice_relay_type_get_type (void);
#define NICE_TYPE_RELAY_TYPE (nice_relay_type_get_type())
G_END_DECLS

#endif /* __AGENT_ENUM_TYPES_H__ */



