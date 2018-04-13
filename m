From: mtk.manpages@gmail.com (Michael Kerrisk (man-pages))
Date: Fri, 13 Apr 2018 21:26:14 +0200
Subject: [manpages PATCH] capabilities.7: describe namespaced file
	capabilities
In-Reply-To: <CAG48ez39UyiqE539rS6RSayj4tPBfQPHPiQ=48Roi55qFJLT7g@mail.gmail.com>
References: <20180109185218.GA21753@mail.hallyn.com>
	<CAG48ez39UyiqE539rS6RSayj4tPBfQPHPiQ=48Roi55qFJLT7g@mail.gmail.com>
Message-ID: <06189756-dbc5-ebd0-ccdd-d937d6198530@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello Serge, Jann,

On 01/16/2018 06:26 PM, Jann Horn wrote:
> On Tue, Jan 9, 2018 at 7:52 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> Update the capabilities(7)  manpage with a description of the
>> new-ish namespaced file capability support.
>>
>> A note on userspace tools:  since the kernel will automatically
>> convert between v2 and v3 xattrs, and translate nsroot between
>> v3 xattrs, we can make do with the current getcap(8) and setcap(8)
>> tools. I.e. a user on the host can create a transient user namespace
>> with the appropriate mappings and run setcap(8) there.  The kernel
>> will automatically write a v3 xattr with the transient namespace's
>> root user as nsroot.

After a long gap, I have come back to the task of working up
some text to describe file capability versioning and namespaced file
capabilities.

I still not convinced I've captured things correctly, and I still
have a few questions (see below). But first, here's the text that
I have so far (suggestions for improvements welcome). These changes
have already been pushed to the Git repo.

   File capability mask versioning
       To allow extensibility, the kernel supports a scheme to  encode
       a   version  number  inside  the  security.capability  extended
       attribute that is used to implement file  capabilities.   These
       version  numbers  are  internal  to the implementation, and not
       directly visible to user-space applications.  To date, the fol?
       lowing versions are supported:

       VFS_CAP_REVISION_1
              This  was  the  original file capability implementation,
              which supported 32-bit masks for file capabilities.

       VFS_CAP_REVISION_2 (since Linux 2.6.25)
              This version allows for file capability masks  that  are
              64 bits in size, and was necessary as the number of sup?
              ported capabilities grew beyond 32.  The  kernel  trans?
              parently  continues  to  support  the execution of files
              that have 32-bit version 1 capability  masks,  but  when
              adding  capabilities  to  files  that did not previously
              have capabilities,  or  modifying  the  capabilities  of
              existing  files,  it  automatically  uses  the version 2
              scheme (or possibly the version 3 scheme,  as  described
              below).

       VFS_CAP_REVISION_3 (since Linux 4.14)
              Version  3  file  capabilities  are  provided to support
              namespaced file capabilities (described below).

              As with version 2 file capabilities, version 3  capabil?
              ity  masks  are  64  bits in size.  But in addition, the
              root user ID  of  namespace  is  encoded  in  the  secu?
              rity.capability extended attribute.  (A namespace's root
              user ID is the value that user ID 0 inside  that  names?
              pace maps to in the initial user namespace.)

["namespace root user ID" is my term for what Serge called nsroot.
I think it's a little more meaningful, but I am also open to suggestions
for a better term.]

              Version 3 file capabilities are designed to coexist with
              version 2 capabilities; that is, on a modern Linux  sys?
              tem, there may be some files with version 2 capabilities
              while others have version 3 capabilities.

       Before Linux 4.14, the only kind of capability mask that  could
       be  attached  to  a  file was a VFS_CAP_REVISION_2 mask.  Since
       Linux 4.14, the version of the capability mask that is attached
       to  a  file  depends  on  the  circumstances in which the secu?
       rity.capability extended attribute was created.

       Starting  with  Linux  4.14,  a  security.capability   extended
       attribute  is automatically created as (or converted to) a ver?
       sion 3 (VFS_CAP_REVISION_3) attribute if both of the  following
       are true:

       (1) The  thread  writing  the attribute resides in a noninitial
           namespace.  (More precisely: the thread resides in  a  user
           namespace  other  than  the  one  from which the underlying
           filesystem was mounted.)

       (2) The thread has the CAP_SETFCAP  capability  over  the  file
           inode,  meaning  that  (a)  the  thread has the CAP_SETFCAP
           capability in its own user namespace; and (b) the  UID  and
           GID  of  the  file inode have mappings in the writer's user
           namespace.

           ???????????????????????????????????????????????????????
           ?FIXME                                                ?
           ???????????????????????????????????????????????????????
           ?Does there also need to be some kind  of  credential ?
           ?match  between  the  file  and the namespace creator ?
           ?UID?                                                 ?
           ???????????????????????????????????????????????????????

       When   a   VFS_CAP_REVISION_3   security.capability    extended
       attribute is created, the root user ID of the creating thread's
       user namespace is saved in the extended attribute.

       By contrast, creating a security.capability extended  attribute
       from  a  privileged  (CAP_SETFCAP)  thread  that resides in the
       namespace where the the underlying filesystem was mounted (this
       normally   means  the  initial  user  namespace)  automatically
       results in a version 2 (VFS_CAP_REVISION_2) attribute.

       Note that a file can have either a version 2  or  a  version  3
       security.capability  extended attribute associated with it, but
       not both: creation or modification of  the  security.capability
       extended   attribute  will  automatically  modify  the  version
       according to the circumstances in which the extended  attribute
       is created or modified.

       [...]

   Namespaced file capabilities
       Traditional  (i.e., version 2) file capabilities associate only
       a set of capability masks with a binary executable file.   When
       a  process  executes  a binary with such capabilities, it gains
       the associated capabilities (within its user namespace) as  per
       the  rules  described  above in "Transformation of capabilities
       during execve()".

       Because version 2 file capabilities confer capabilities to  the
       executing process regardless of which user namespace it resides
       in, only privileged processes are permitted to associate  capa?
       bilities  with a file.  Here, "privileged" means a process that
       has the CAP_SETFCAP capability in the user namespace where  the
       filesystem  was  mounted (normally the initial user namespace).
       This limitation renders file capabilities useless  for  certain
       use  cases.  For example, in user-namespaced containers, it can
       be desirable to be able to create a binary that  confers  capa?
       bilities  only to processes executed inside that container, but
       not to processes that are executed outside the container.

       Linux 4.14 added so-called namespaced file capabilities to sup?
       port such use cases.  Namespaced file capabilities are recorded
       as version  3  (i.e.,  VFS_CAP_REVISION_3)  security.capability
       extended  attributes.   Such an attribute is automatically cre?
       ated when a process that resides in a noninitial user namespace
       associates  (setxattr(2))  file  capabilities with a file whose
       user ID matches the user ID of the creator  of  the  namespace.
       In  this case, the kernel records not just the capability masks
       in the extended attribute, but also the namespace root user ID.
       For  further  details,  see  File  capability  mask versioning,
       above.

       As with a binary that has VFS_CAP_REVISION_2 file capabilities,
       a  binary  with  VFS_CAP_REVISION_3  file  capabilities confers
       capabilities to a process during execve().  However,  capabili?
       ties  are conferred only if the binary is executed by a process
       that resides in a user namespace whose UID 0 maps to  the  root
       user  ID  that is saved in the extended attribute, or when exe?
       cuted by a process that resides in descendant of such a  names?
       pace.

The following is Serge's original patch, with some questions
from me.

>> Signed-off-by: Serge Hallyn <shallyn@cisco.com>
>> ---
>>  man7/capabilities.7 | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/man7/capabilities.7 b/man7/capabilities.7
>> index 166eaaf..76e7e02 100644
>> --- a/man7/capabilities.7
>> +++ b/man7/capabilities.7
>> @@ -936,6 +936,50 @@ if we specify the effective flag as being enabled for any capability,
>>  then the effective flag must also be specified as enabled
>>  for all other capabilities for which the corresponding permitted or
>>  inheritable flags is enabled.
>> +.PP
>> +Until 4.13, only VFS_CAP_REVISION_2 xattrs were supported.  These store only
>> +the capabilities to be applied to the file, with no record of the writer's
>> +credentials.  Therefore only privileged users can be trusted to write them, and
>> +.BR CAP_SETFCAP
>> +over the user namespace which mounted the filesystem (usually the initial user
>> +namespace) is required.  This makes it impossible to write file capabilities
>> +from a user namespaced container, which causes some package updates to fail.
>> +.PP
>> +In order to support setting file capabilities in containers, the
>> +kernel must be able to identify whether the task executing the
>> +file will be constrained to a subset of the resources over which
>> +the writer of the file capabilities has privilege.  To this end,
>> +since 4.13, VFS_CAP_REVISION_3 capabilities store the user ID
>> +of the root user in the writer's namespace ("nsroot").  Hence the writer only
>> +requires
>> +.IP 1.
>> +.BR CAP_SETFCAP
>> +over the file inode, meaning the writing task must have
>> +.BR CAP_SETFCAP
>> +over a user namespace into which the inode's owning user ID is mapped.
>> +.PP
>> +and
>> +.IP 2.
>> +.BR CAP_SETFCAP
>> +over the writer's own user namespace.
> 
> I think that the following would be clearer (but technically
> equivalent): "Hence the writer only requires CAP_SETFCAP over the file
> inode, meaning that the writing task must have CAP_SETFCAP in its own
> user namespace and the UID and GID of the file inode must be mapped in
> the writing task's user namespace.".

I've tried to capture that idea in my text above. Was I successful?

>> +A VFS_CAP_REVISION_3 file capability will take effect only when run in a user namespace
>> +whose UID 0 maps to the saved "nsroot", or a descendant of such a namespace.
>> +.PP
>> +Users with the required privilege may use
>> +.BR setxattr(2)
>> +to request either a VFS_CAP_REVISION_2 or VFS_CAP_REVISION_3 write.
>> +The kernel will automatically convert a VFS_CAP_REVISION_2 to a
>> +VFS_CAP_REVISION_3 extended attribute with the "nsroot"
>> +set to the root user in the writer's user namespace, or, if a VFS_CAP_REVISION_3
>> +extended attribute is specified, then the kernel will map the
>> +specified root user ID (which must be a valid user ID mapped in the caller's
>> +user namespace) into the initial user namespace.
> 
> Really, "into the initial user namespace"? That may be true for the
> kernel-internal representation, but the on-disk representation is the
> mapping into the user namespace that contains the mount namespace into
> which the file system was mounted, right? This would become observable
> when a file system is mounted in a different namespace than before, or
> when working with FUSE in a namespace.
> 
>> Likewise,
>> +.BR getxattr(2)
>> +results will be converted and simplified to show a VFS_CAP_REVISION_2
>> +extended attribute, if a VFS_CAP_REVISION_3 applies to the caller's
>> +namespace, or to map the VFS_CAP_REVISION_3 root user ID into the
>> +caller's namespace.

I haven't captured that last paragraph in my text. I'm not sure I
understand the idea being presented. Serge, could you elaborate?

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
