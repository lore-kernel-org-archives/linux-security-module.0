From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 19 Apr 2018 19:04:38 -0500
Subject: [manpages PATCH] capabilities.7: describe namespaced file
	capabilities
In-Reply-To: <06189756-dbc5-ebd0-ccdd-d937d6198530@gmail.com>
References: <20180109185218.GA21753@mail.hallyn.com>
	<CAG48ez39UyiqE539rS6RSayj4tPBfQPHPiQ=48Roi55qFJLT7g@mail.gmail.com>
	<06189756-dbc5-ebd0-ccdd-d937d6198530@gmail.com>
Message-ID: <20180420000438.GB8785@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Michael Kerrisk (man-pages) (mtk.manpages at gmail.com):
> Hello Serge, Jann,
> 
> On 01/16/2018 06:26 PM, Jann Horn wrote:
> > On Tue, Jan 9, 2018 at 7:52 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >> Update the capabilities(7)  manpage with a description of the
> >> new-ish namespaced file capability support.
> >>
> >> A note on userspace tools:  since the kernel will automatically
> >> convert between v2 and v3 xattrs, and translate nsroot between
> >> v3 xattrs, we can make do with the current getcap(8) and setcap(8)
> >> tools. I.e. a user on the host can create a transient user namespace
> >> with the appropriate mappings and run setcap(8) there.  The kernel
> >> will automatically write a v3 xattr with the transient namespace's
> >> root user as nsroot.
> 
> After a long gap, I have come back to the task of working up
> some text to describe file capability versioning and namespaced file
> capabilities.
> 
> I still not convinced I've captured things correctly, and I still
> have a few questions (see below). But first, here's the text that
> I have so far (suggestions for improvements welcome). These changes
> have already been pushed to the Git repo.
> 
>    File capability mask versioning
>        To allow extensibility, the kernel supports a scheme to  encode
>        a   version  number  inside  the  security.capability  extended
>        attribute that is used to implement file  capabilities.   These
>        version  numbers  are  internal  to the implementation, and not
>        directly visible to user-space applications.  To date, the fol?
>        lowing versions are supported:
> 
>        VFS_CAP_REVISION_1
>               This  was  the  original file capability implementation,
>               which supported 32-bit masks for file capabilities.
> 
>        VFS_CAP_REVISION_2 (since Linux 2.6.25)
>               This version allows for file capability masks  that  are
>               64 bits in size, and was necessary as the number of sup?
>               ported capabilities grew beyond 32.  The  kernel  trans?
>               parently  continues  to  support  the execution of files
>               that have 32-bit version 1 capability  masks,  but  when
>               adding  capabilities  to  files  that did not previously
>               have capabilities,  or  modifying  the  capabilities  of
>               existing  files,  it  automatically  uses  the version 2
>               scheme (or possibly the version 3 scheme,  as  described
>               below).
> 
>        VFS_CAP_REVISION_3 (since Linux 4.14)
>               Version  3  file  capabilities  are  provided to support
>               namespaced file capabilities (described below).
> 
>               As with version 2 file capabilities, version 3  capabil?
>               ity  masks  are  64  bits in size.  But in addition, the
>               root user ID  of  namespace  is  encoded  in  the  secu?
>               rity.capability extended attribute.  (A namespace's root
>               user ID is the value that user ID 0 inside  that  names?
>               pace maps to in the initial user namespace.)
> 
> ["namespace root user ID" is my term for what Serge called nsroot.
> I think it's a little more meaningful, but I am also open to suggestions
> for a better term.]

"mapped root ID" maybe?

> 
>               Version 3 file capabilities are designed to coexist with
>               version 2 capabilities; that is, on a modern Linux  sys?
>               tem, there may be some files with version 2 capabilities
>               while others have version 3 capabilities.
> 
>        Before Linux 4.14, the only kind of capability mask that  could
>        be  attached  to  a  file was a VFS_CAP_REVISION_2 mask.  Since
>        Linux 4.14, the version of the capability mask that is attached
>        to  a  file  depends  on  the  circumstances in which the secu?
>        rity.capability extended attribute was created.
> 
>        Starting  with  Linux  4.14,  a  security.capability   extended
>        attribute  is automatically created as (or converted to) a ver?
>        sion 3 (VFS_CAP_REVISION_3) attribute if both of the  following
>        are true:
> 
>        (1) The  thread  writing  the attribute resides in a noninitial
>            namespace.  (More precisely: the thread resides in  a  user
>            namespace  other  than  the  one  from which the underlying
>            filesystem was mounted.)
> 
>        (2) The thread has the CAP_SETFCAP  capability  over  the  file
>            inode,  meaning  that  (a)  the  thread has the CAP_SETFCAP
>            capability in its own user namespace; and (b) the  UID  and
>            GID  of  the  file inode have mappings in the writer's user
>            namespace.
> 
>            ???????????????????????????????????????????????????????
>            ?FIXME                                                ?
>            ???????????????????????????????????????????????????????
>            ?Does there also need to be some kind  of  credential ?
>            ?match  between  the  file  and the namespace creator ?
>            ?UID?                                                 ?
>            ???????????????????????????????????????????????????????
> 
>        When   a   VFS_CAP_REVISION_3   security.capability    extended
>        attribute is created, the root user ID of the creating thread's

Importantly, that is only when a V3 is *automatically* created to replace
a V2.  When a V3 is written, then the .rootid in the V3 is (mapped and)
written as specified.

For instance, root in a namespace can write a V3 xattr that only holds true
in a child namespace where its uid 100k (which could be 200k in the initial
userns) is mapped to root.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
