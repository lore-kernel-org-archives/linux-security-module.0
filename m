From: christian@brauner.io (Christian Brauner)
Date: Fri, 10 Aug 2018 18:13:26 +0200
Subject: [PATCH 0/9] libcap: add user namespace fscaps support
Message-ID: <20180810161335.27036-1-christian@brauner.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hey everyone,

Starting with kernel 4.14 fcaps support in user namespaces was added.
libcap currently does not support fcaps in user namespaces. This series
adds support for fcaps in user namespaces. To this end two new functions
are introduced:

1. cap_get_nsowner()
   Get the uid associated with the capability sets as seen in the
   current user namespace.
   For example, assume that uid 0 in a non-initial userns is mapped to
   uid 1000000 on the host/initial user namespace. Further assume one of
   the following:
   a. A VFS_CAP_REVISION_2 capability has been set from within the
      non-initial user namespace.
   b. A VFS_CAP_REVISION_3 capability with nsowner 0 has been set from
      within said non-initial user namespace.
   c. A VFS_CAP_REVISION_3 capability with nsowner 100000 has been set
      from the initial user namespace.
   In any of these cases, cap_get_nsowner() will return 0 from within
   said non-initial user namespace, and will return 1000000 from the
   parent user namespace that wrote this mapping.

2. cap_set_nsowner()
   Set the owning uid associated with the capability sets.
   For example, assume that uid 0 in a non-initial userns is mapped to
   uid 1000000 on the host. Now, cap_set_nsowner() sets the uid for the
   capabilitiy sets to 1000000 in the parent (host) user namespace of
   the non-initial user namespace. This will cause a capability to be
   set that is useless on the host but interpreted in every user
   namespace that has established the same mapping.

More details on how to handle cases where libcap is compiled on a
VFS_CAP_REVISION_3 kernel but used on a VFS_CAP_REVISION_2 kernel can be
found in the individual commits.

Thanks!
Christian

Christian Brauner (9):
  cap_file: use v3 xattr macros
  capability: update to new uapi header
  cap_file: use struct vfs_ns_cap_data if possible
  cap_file: add new rootid argument
  cap_file: initialize rootid in _fcaps_load()
  capability: add cap_get_nsowner()
  cap_file: save rootid in _fcaps_save()
  cap_file: handle run- vs buildtime vfs cap support
  capability: add cap_set_nsowner()

 libcap/cap_file.c                      | 107 ++++++++++++++++++++++++-
 libcap/include/sys/capability.h        |   2 +
 libcap/include/uapi/linux/capability.h |  39 ++++++---
 libcap/libcap.h                        |   1 +
 4 files changed, 134 insertions(+), 15 deletions(-)

-- 
2.17.1
