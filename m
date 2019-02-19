Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C7C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DF6217D9
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfBSQ2C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:28:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbfBSQ2C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1EEC3C5C;
        Tue, 19 Feb 2019 16:28:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4256013D;
        Tue, 19 Feb 2019 16:27:50 +0000 (UTC)
Subject: [PATCH 00/43] VFS: Introduce filesystem context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Tejun Heo <tj@kernel.org>, fenghua.yu@intel.com,
        "Eric W. Biederman" <ebiederm@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cgroups@vger.kernel.org, stable@kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:27:49 +0000
Message-ID: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 16:28:01 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Here's a set of patches that creates a filesystem context for the
parameterisation of the superblock lookup/creation/reconfiguration
procedure.  This permits more flexible up-front parameter parsing and the
specification of more interesting parameters (e.g. namespace information)
to be made without the need to hack the ->mount() interface on invisible
file_system_type structs.

The patches that added system calls and other UAPI bits are deferred to a
separate patch series.  Taking the core patchset upstream would allow
mount-api'isation of non-trivial filesystems to proceed, even without the
system calls.

Note that these patches do not change how the mount procedure works in the
case that a matching superblock is found with different parameters.  I know
that's something some people really want to fix, but it cannot be easily
done for mount(2).  It's something that can be looked at as a parameter
settable with the new system calls - but that's for later.

The aim is to allow Miklós Szeredi's idea of doing something like:

	fd = fsopen("nfs");
	fsconfig(fd, FSCONFIG_SET_STRING, "option", "val", 0);
	fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
	mfd = fsmount(fd, MS_NODEV);
	move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

that he presented at LSF-2017 to be implemented.

I didn't use netlink as that would make the core kernel depend on
CONFIG_NET and CONFIG_NETLINK and would introduce network namespacing
issues.

I've implemented filesystem context handling for procfs, mqueue, cpuset,
kernfs, sysfs, cgroup and afs filesystems in this series.  I've also done
NFS and had a stab at btrfs, both of which can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=R49

I've also converted all the trivial filesystems plus the tmpfs/ramfs
complex, which can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Unconverted filesystems are handled by a legacy filesystem wrapper.


====================
WHY DO WE WANT THIS?
====================

Firstly, there's a bunch of problems with the mount(2) syscall:

 (1) It's actually six or seven different interfaces rolled into one and
     weird combinations of flags make it do different things beyond the
     original specification of the syscall.

 (2) It produces a particularly large and diverse set of errors, which have
     to be mapped back to a small error code.  Yes, there's dmesg - if you
     have it configured - but you can't necessarily see that if you're
     doing a mount inside of a container.

 (3) It copies a PAGE_SIZE block of data for each of the type, device name
     and options.

 (4) The size of the buffers is PAGE_SIZE - and this is arch dependent.

 (5) You can't mount into another mount namespace.  I could, for example,
     build a container without having to be in that container's namespace
     if I can do it from outside.

 (6) It's not really geared for the specification of multiple sources, but
     some filesystems really want that - overlayfs, for example.

 (7) We've hit the limit on MS_* flags, but we might want to add more
     mountpoint attributes (such as automount suppression).

and some problems in the internal kernel API:

 (1) There's no defined way to supply namespace configuration for the
     superblock - so, for instance, I can't say that I want to create a
     superblock in a particular network namespace (on automount, say).

     NFS hacks around this by creating multiple shadow file_system_types
     with different ->mount() ops that abuse the data pointer.

 (2) When calling mount internally, unless you have NFS-like hacks, you
     have to generate or otherwise provide text config data which then gets
     parsed, when some of the time you could bypass the parsing stage
     entirely.

 (3) The amount of data in the data buffer is not known, but the data
     buffer might be on a kernel stack somewhere, leading to the
     possibility of tripping the stack underrun guard.

and other issues too:

 (1) Superblock remount in some filesystems applies options on an as-parsed
     basis, so if there's a parse failure, a partial alteration with no
     rollback is effected.

 (2) Under some circumstances, the mount data may get copied multiple times
     so that it can have multiple parsers applied to it or because it has
     to be parsed multiple times - for instance, once to get the
     preliminary info required to access the on-disk superblock and then
     again to update the superblock record in the kernel.

I want to be able to add support for a bunch of things:

 (1) UID, GID and Project ID mapping/translation.  I want to be able to
     install a translation table of some sort on the superblock to
     translate source identifiers (which may be foreign numeric UIDs/GIDs,
     text names, GUIDs) into system identifiers.  This needs to be done
     before the superblock is published[*].

     Note that this may, for example, involve using the context and the
     superblock held therein to issue an RPC to a server to look up
     translations.

     [*] By "published" I mean made available through mount so that other
     	 userspace processes can access it by path.

     Maybe specifying a translation range element with something like:

	fsconfig(fd, fsconfig_translate_uid, "<srcuid> <nsuid> <count>", 0, 0);

     The translation information also needs to propagate over an automount
     in some circumstances.

 (2) Namespace configuration.  I want to be able to tell the superblock
     creation process what namespaces should be applied when it created (in
     particular the userns and netns) for containerisation purposes, e.g.:

	fsconfig(fd, FSCONFIG_SET_NAMESPACE, "user", 0, userns_fd);
	fsconfig(fd, FSCONFIG_SET_NAMESPACE, "net", 0, netns_fd);

 (3) Namespace propagation.  I want to have a properly defined mechanism
     for propagating namespace configuration over automounts within the
     kernel.  This will be particularly useful for network filesystems.

 (4) Pre-mount attribute query.  A chunk of the changes is actually the
     fsinfo() syscall to query attributes of the filesystem beyond what's
     available in statx() and statfs().  This will allow a created
     superblock to be queried before it is published.

 (5) Upcall for configuration.  I would like to be able to query
     configuration that's stored in userspace when an automount is made.
     For instance, to look up network parameters for NFS or to find a cache
     selector for fscache.

     The internal fs_context could be passed to the upcall process or the
     kernel could read a config file directly if named appropriately for the
     superblock, perhaps:

	[/etc/fscontext.d/afs/example.com/cell.cfg]
	realm = EXAMPLE.COM
	translation = uid,3000,4000,100
	fscache = tag=fred

 (6) Event notifications.  I want to be able to install a watch on a
     superblock before it is published to catch things like quota events
     and EIO.

 (7) Large and binary parameters.  There might be at some point a need to
     pass large/binary objects like Microsoft PACs around.  If I understand
     PACs correctly, you can obtain these from the Kerberos server and then
     pass them to the file server when you connect.

     Having it possible to pass large or binary objects as individual
     fsconfig calls make parsing these trivial.  OTOH, some or all of this
     can potentially be handled with the use of the keyrings interface - as
     the afs filesystem does for passing kerberos tokens around; it's just
     that that seems overkill for a parameter you may only need once.


===================
SIGNIFICANT CHANGES
===================

 ver #14:

 (*) Al has massively hacked the patches around, breaking it up a bit into
     subpatches and reworking the security (which is already upstream).

 ver #13:

 (*) Fix the default handling of the source parameter for a filesystem that
     doesn't support it (stash the string to fc->source).

 (*) Fix cgroup mounting.  This is slightly awkward as we can't call
     vfs_get_tree() from within the ->get_tree() op as the former drops
     s_umount before returning.

 (*) Fixes/cleanups from Eric Biederman, including:

     - Fix error handling in do_remount().

 ver #12:

 (*) Rebased on v4.19-rc3.

 (*) Added three new context purposes: mount for hidden root, reconfigure
     for unmount, reconfigure for emergency remount.

 (*) Added a parameter for the new purpose into vfs_dup_fs_context().

 (*) Moved the reconfiguration hook from struct super_operations to struct
     fs_context_operations so they can be handled through the legacy
     wrapper.  mount -o remount now goes through that.

 (*) Changed the parameter description in the following ways:

     - Nominated one master name for each parameter, held in a simple
       string pointer array.  This makes it easy to simply look up a name
       for that parameter for logging.

     - Added a table of additional names for parameters.  The name chosen
       can be used to influence the action of the parameter.

     - Noted which parameter is the source specifier, if there is one.

 (*) Use correct user_ns for a new pidns superblock.

 (*) Fix mqueue to not crash on mounting.

 (*) Make VFS sample programs dependent on X86 to avoid errors in
     autobuilders due to unset syscall IDs in other arches.

 (*) [Miklós] Fixed subtype handling.

 ver #11:

 (*) Fixed AppArmor.

 (*) Capitalised all the UAPI constants.

 (*) Explicitly numbered the FSCONFIG_* UAPI constants.

 (*) Removed all the places ANON_INODES is selected.

 (*) Fixed a bug whereby the context gets freed twice (which broke mounts of
     procfs).

 (*) Split fsinfo() off into its own patch series.

 ver #10:

 (*) Renamed "option" to "parameter" in a number of places.

 (*) Replaced the use of write() to drive the configuration with an fsconfig()
     syscall.  This also allows at-style paths and fds to be presented as typed
     object.

 (*) Routed the key=value parameter concept all the way through from the
     fsconfig() system call to the LSM and filesystem.

 (*) Added a parameter-description concept and helper functions to help
     interpret a parameter and possibly convert the value.

 (*) Made it possible to query the parameter description using the fsinfo()
     syscall.  Added a test-fs-query sample to dump the parameters used by a
     filesystem.

 ver #9:

 (*) Dropped the fd cookie stuff and the FMODE_*/O_* split stuff.

 (*) Al added an open_tree() system call to allow a mount tree to be picked
     referenced or cloned into an O_PATH-style fd.  This can then be used
     with sys_move_mount().  Dropped the O_CLONE_MOUNT and O_NON_RECURSIVE
     open() flags.

 (*) Brought error logging back in, though only in the fs_context and not
     in the task_struct.

 (*) Separated MS_REMOUNT|MS_BIND handling from MS_REMOUNT handling.

 (*) Used anon_inodes for the fd returned by fsopen() and fspick().  This
     requires making it unconditional.

 (*) Fixed lots of bugs.  Especial thanks to Al and Eric Biggers for
     finding them and providing patches.

 (*) Wrote manual pages, which I'll post separately.

 ver #8:

 (*) Changed the way fsmount() mounts into the namespace according to some
     of Al's ideas.

 (*) Put better typing on the fd cookie obtained from __fdget() & co..

 (*) Stored the fd cookie in struct nameidata rather than the dfd number.

 (*) Changed sys_fsmount() to return an O_PATH-style fd rather than
     actually mounting into the mount namespace.

 (*) Separated internal FMODE_* handling from O_* handling to free up
     certain O_* flag numbers.

 (*) Added two new open flags (O_CLONE_MOUNT and O_NON_RECURSIVE) for use
     with open(O_PATH) to copy a mount or mount-subtree to an O_PATH fd.

 (*) Added a new syscall, sys_move_mount(), to move a mount from an
     dfd+path source to a dfd+path destination.

 (*) Added a file->f_mode flag (FMODE_NEED_UNMOUNT) that indicates that the
     vfsmount attached to file->f_path needs 'unmounting' if set.

 (*) Made sys_move_mount() clear FMODE_NEED_UNMOUNT if successful.

	[!] This doesn't work quite right.

 (*) Added a new syscall, fsinfo(), to query information about a
     filesystem.  The idea being that this will, in future, work with the
     fd from fsopen() too and permit querying of the parameters and
     metadata before fsmount() is called.

 ver #7:

 (*) Undo an incorrect MS_* -> SB_* conversion.

 (*) Pass the mount data buffer size to all the mount-related functions that
     take the data pointer.  This fixes a problem where someone (say SELinux)
     tries to copy the mount data, assuming it to be a page in size, and
     overruns the buffer - thereby incurring an oops by hitting a guard page.

 (*) Made the AFS filesystem use them as an example.  This is a much easier to
     deal with than with NFS or Ext4 as there are very few mount options.

 ver #6:

 (*) Dropped the supplementary error string facility for the moment.

 (*) Dropped the NFS patches for the moment.

 (*) Dropped the reserved file descriptor argument from fsopen() and
     replaced it with three reserved pointers that must be NULL.

 ver #5:

 (*) Renamed sb_config -> fs_context and adjusted variable names.

 (*) Differentiated the flags in sb->s_flags (now named SB_*) from those
     passed to mount(2) (named MS_*).

 (*) Renamed __vfs_new_fs_context() to vfs_new_fs_context() and made the
     caller always provide a struct file_system_type pointer and the
     parameters required.

 (*) Got rid of vfs_submount_fc() in favour of passing
     FS_CONTEXT_FOR_SUBMOUNT to vfs_new_fs_context().  The purpose is now
     used more.

 (*) Call ->validate() on the remount path.

 (*) Got rid of the inode locking in sys_fsmount().

 (*) Call security_sb_mountpoint() in the mount(2) path.

 ver #4:

 (*) Split the sb_config patch up somewhat.

 (*) Made the supplementary error string facility something attached to the
     task_struct rather than the sb_config so that error messages can be
     obtained from NFS doing a mount-root-and-pathwalk inside the
     nfs_get_tree() operation.

     Further, made this managed and read by prctl rather than through the
     mount fd so that it's more generally available.

 ver #3:

 (*) Rebased on 4.12-rc1.

 (*) Split the NFS patch up somewhat.

 ver #2:

 (*) Removed the ->fill_super() from sb_config_operations and passed it in
     directly to functions that want to call it.  NFS now calls
     nfs_fill_super() directly rather than jumping through a pointer to it
     since there's only the one option at the moment.

 (*) Removed ->mnt_ns and ->sb from sb_config and moved ->pid_ns into
     proc_sb_config.

 (*) Renamed create_super -> get_tree.

 (*) Renamed struct mount_context to struct sb_config and amended various
     variable names.

 (*) sys_fsmount() acquired AT_* flags and MS_* flags (for MNT_* flags)
     arguments.

 ver #1:

 (*) Split the sb_config stuff out into its own header.

 (*) Support non-context aware filesystems through a special set of
     sb_config operations.

 (*) Stored the created superblock and root dentry into the sb_config after
     creation rather than directly into a vfsmount.  This allows some
     arguments to be removed to various NFS functions.

 (*) Added an explicit superblock-creation step.  This allows a created
     superblock to then be mounted multiple times.

 (*) Added a flag to say that the sb_config is degraded and cannot have
     another go at having a superblock creation whilst getting rid of the
     one that says it's already mounted.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

at tag:

	vfs-work-mount

and here:

	https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git

on branch:

	work.mount

David
---
Al Viro (21):
      fix cgroup_do_mount() handling of failure exits
      cgroup: saner refcounting for cgroup_root
      kill kernfs_pin_sb()
      separate copying and locking mount tree on cross-userns copies
      saner handling of temporary namespaces
      new helpers: vfs_create_mount(), fc_mount()
      teach vfs_get_tree() to handle subtype, switch do_new_mount() to it
      vfs_get_tree(): evict the call of security_sb_kern_mount()
      fs_context flavour for submounts
      introduce fs_context methods
      convenience helpers: vfs_get_super() and sget_fc()
      introduce cloning of fs_context
      cgroup: start switching to fs_context
      cgroup: fold cgroup1_mount() into cgroup1_get_tree()
      cgroup: take options parsing into ->parse_monolithic()
      cgroup1: switch to option-by-option parsing
      cgroup2: switch to option-by-option parsing
      cgroup: stash cgroup_root reference into cgroup_fs_context
      cgroup_do_mount(): massage calling conventions
      cgroup1_get_tree(): separate "get cgroup_root to use" into a separate helper
      cgroup: store a reference to cgroup_ns into cgroup_fs_context

David Howells (22):
      vfs: Introduce fs_context, switch vfs_kern_mount() to it.
      new helper: do_new_mount_fc()
      convert do_remount_sb() to fs_context
      vfs: Introduce logging functions
      vfs: Add configuration parser helpers
      vfs: Add LSM hooks for the new mount API
      selinux: Implement the new mount API LSM hooks
      smack: Implement filesystem context security hooks
      vfs: Put security flags into the fs_context struct
      vfs: Implement a filesystem superblock creation/configuration context
      procfs: Move proc_fill_super() to fs/proc/root.c
      proc: Add fs_context support to procfs
      ipc: Convert mqueue fs to fs_context
      kernfs, sysfs, cgroup, intel_rdt: Support fs_context
      cpuset: Use fs_context
      hugetlbfs: Convert to fs_context
      vfs: Remove kern_mount_data()
      vfs: Provide documentation for new mount API
      vfs: Implement logging through fs_context
      vfs: Add some logging to the core users of the fs_context log
      afs: Add fs_context support
      afs: Use fs_context to pass parameters over automount


 Documentation/filesystems/mount_api.txt |  709 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h  |   16 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c  |  185 +++++---
 fs/Kconfig                              |    7 
 fs/Makefile                             |    3 
 fs/afs/internal.h                       |    9 
 fs/afs/mntpt.c                          |  149 +++----
 fs/afs/super.c                          |  430 ++++++++++---------
 fs/afs/volume.c                         |    4 
 fs/filesystems.c                        |    4 
 fs/fs_context.c                         |  642 ++++++++++++++++++++++++++++
 fs/fs_parser.c                          |  447 ++++++++++++++++++++
 fs/hugetlbfs/inode.c                    |  358 +++++++++-------
 fs/internal.h                           |   13 -
 fs/kernfs/kernfs-internal.h             |    1 
 fs/kernfs/mount.c                       |  127 ++----
 fs/mount.h                              |    5 
 fs/namei.c                              |    4 
 fs/namespace.c                          |  395 +++++++++++------
 fs/pnode.c                              |    5 
 fs/pnode.h                              |    3 
 fs/proc/inode.c                         |   52 --
 fs/proc/internal.h                      |    5 
 fs/proc/root.c                          |  236 ++++++++--
 fs/super.c                              |  344 ++++++++++++---
 fs/sysfs/mount.c                        |   73 ++-
 include/linux/errno.h                   |    1 
 include/linux/fs.h                      |   14 -
 include/linux/fs_context.h              |  188 ++++++++
 include/linux/fs_parser.h               |  176 ++++++++
 include/linux/kernfs.h                  |   39 +-
 include/linux/lsm_hooks.h               |   21 +
 include/linux/mount.h                   |    3 
 include/linux/security.h                |   18 +
 ipc/mqueue.c                            |   94 +++-
 ipc/namespace.c                         |    2 
 kernel/cgroup/cgroup-internal.h         |   51 +-
 kernel/cgroup/cgroup-v1.c               |  428 +++++++++----------
 kernel/cgroup/cgroup.c                  |  240 ++++++----
 kernel/cgroup/cpuset.c                  |   56 ++
 security/security.c                     |   10 
 security/selinux/hooks.c                |   88 ++++
 security/selinux/include/security.h     |   10 
 security/smack/smack.h                  |   19 -
 security/smack/smack_lsm.c              |   92 ++++
 45 files changed, 4400 insertions(+), 1376 deletions(-)
 create mode 100644 Documentation/filesystems/mount_api.txt
 create mode 100644 fs/fs_context.c
 create mode 100644 fs/fs_parser.c
 create mode 100644 include/linux/fs_context.h
 create mode 100644 include/linux/fs_parser.h

