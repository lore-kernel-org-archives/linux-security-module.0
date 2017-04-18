From: paul@paul-moore.com (Paul Moore)
Date: Tue, 18 Apr 2017 15:20:29 -0400
Subject: [GIT PULL] SELinux patches for 4.12
Message-ID: <CAHC9VhSX2R6+eof6JPVyjzCmL0gFMMO=Liw15vVyED502eJ2gQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

A whopping 31 SELinux patches for v4.12, although 25 of these are the
small little patches from Markus.  Beyond those 25 patches, the
remaining six are equally trivial with the only real standout being
Stephen's patch to reorder the DAC_OVERRIDE and DAC_READ_SEARCH
checks.  Everything passes selinux-testsuite and merges cleanly with
the linux-security/next branch; please apply.

Thanks,
-Paul

---
The following changes since commit ca97d939db114c8d1619e10a3b82af8615372dae:

 security: mark LSM hooks as __ro_after_init (2017-03-06 11:00:15 +1100)

are available in the git repository at:

 git://git.infradead.org/users/pcmoore/selinux stable-4.12

for you to fetch changes up to cae303df3f379f04ce7efadb2e30de460918b302:

 selinux: Fix an uninitialized variable bug (2017-03-31 15:16:18 -0400)

----------------------------------------------------------------
Alexander Potapenko (1):
     selinux: check for address length in selinux_socket_bind()

Dan Carpenter (1):
     selinux: Fix an uninitialized variable bug

James Morris (1):
     selinux: constify nlmsg permission tables

Markus Elfring (25):
     selinux: Use kmalloc_array() in cond_init_bool_indexes()
     selinux: Delete an unnecessary return statement in cond_compute_av()
     selinux: Improve size determinations in four functions
     selinux: Use kmalloc_array() in hashtab_create()
     selinux: Adjust four checks for null pointers
     selinux: Use kcalloc() in policydb_index()
     selinux: Delete an unnecessary return statement in policydb_destroy()
     selinux: Return directly after a failed next_entry() in genfs_read()
     selinux: One function call less in genfs_read() after null pointer
              detection
     selinux: Delete an unnecessary variable assignment in
              filename_trans_read()
     selinux: Return directly after a failed next_entry() in range_read()
     selinux: Delete an unnecessary variable initialisation in range_read()
     selinux: Return directly after a failed kzalloc() in cat_read()
     selinux: Return directly after a failed kzalloc() in sens_read()
     selinux: Improve another size determination in sens_read()
     selinux: Return directly after a failed kzalloc() in user_read()
     selinux: Return directly after a failed kzalloc() in type_read()
     selinux: Return directly after a failed kzalloc() in role_read()
     selinux: Return directly after a failed kzalloc() in class_read()
     selinux: Return directly after a failed kzalloc() in common_read()
     selinux: Return directly after a failed kzalloc() in perm_read()
     selinux: Return directly after a failed kzalloc() in roles_init()
     selinux: Use kmalloc_array() in sidtab_init()
     selinux: Adjust two checks for null pointers
     selinuxfs: Use seq_puts() in sel_avc_stats_seq_show()

Matthias Kaehlcke (1):
     selinux: Remove unnecessary check of array base in selinux_set_mapping()

Nicolas Iooss (1):
     selinux: include sys/socket.h in host programs to have PF_MAX

Stephen Smalley (1):
     fs: switch order of CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH checks

fs/namei.c                              | 20 +++++------
scripts/selinux/genheaders/genheaders.c |  1 +
scripts/selinux/mdp/mdp.c               |  1 +
security/selinux/hooks.c                |  8 +++++
security/selinux/nlmsgtab.c             | 10 +++---
security/selinux/selinuxfs.c            |  8 ++---
security/selinux/ss/conditional.c       | 14 ++++----
security/selinux/ss/hashtab.c           | 10 +++---
security/selinux/ss/policydb.c          | 59 ++++++++++++-----------------
security/selinux/ss/services.c          |  2 +-
security/selinux/ss/sidtab.c            |  6 ++--
11 files changed, 69 insertions(+), 70 deletions(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
