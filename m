From: mtk.manpages@gmail.com (Michael Kerrisk (man-pages))
Date: Fri, 4 May 2018 17:10:53 +0200
Subject: [manpages PATCH] capabilities.7: describe namespaced file
	capabilities
In-Reply-To: <CAG48ez2zb2XgKKRpg=mrhG8_C0p+3gKaNeXyRR_ru5=FLB5pNg@mail.gmail.com>
References: <20180109185218.GA21753@mail.hallyn.com>
	<CAG48ez39UyiqE539rS6RSayj4tPBfQPHPiQ=48Roi55qFJLT7g@mail.gmail.com>
	<06189756-dbc5-ebd0-ccdd-d937d6198530@gmail.com>
	<CAG48ez2zb2XgKKRpg=mrhG8_C0p+3gKaNeXyRR_ru5=FLB5pNg@mail.gmail.com>
Message-ID: <de00cb97-5cc5-cfcf-5f7c-69c051678491@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello Jann,

Thanks for your comments. Sorry for the delayed follow-up...

On 04/16/2018 04:10 PM, Jann Horn wrote:
> On Fri, Apr 13, 2018 at 9:26 PM, Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> Hello Serge, Jann,
>>
>> On 01/16/2018 06:26 PM, Jann Horn wrote:
>>> On Tue, Jan 9, 2018 at 7:52 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> [...]
>>        Starting  with  Linux  4.14,  a  security.capability   extended
>>        attribute  is automatically created as (or converted to) a ver?
>>        sion 3 (VFS_CAP_REVISION_3) attribute if both of the  following
>>        are true:
>>
>>        (1) The  thread  writing  the attribute resides in a noninitial
>>            namespace.
> 
> I'm not entirely happy with this - while under most circumstances
> (especially nowadays) correct, isn't this going to confuse readers who
> want to understand the actual rules?

So, you mean that the text should read more likely the parenthesized 
part that follows:

>>            (More precisely: the thread resides in  a  user
>>            namespace  other  than  the  one  from which the underlying
>>            filesystem was mounted.)

?

> I think if you're in a parent namespace of the user namespace that
> mounted the filesystem, you actually can write a VFS_CAP_REVISION_2
> attribute?

I'm not quite clear. Do you mean this as some correction to my text?
Let me see if I grasp your meaning:

(0) First of all, as things currently stand, filesystems can be
    mounted only in the initial user NS (which has no parent). But,
    this will change in the future, according to current work on FUSE.
    Your comment here related to that future. (Right?)

(1) You mean that a process in the parent user NS could write
    (setxattr(2)) a VFS_CAP_REVISION_2 attribute, but what would 
    actually be recorded is a VFS_CAP_REVISION_3 attribute?

>>        (2) The thread has the CAP_SETFCAP  capability  over  the  file
>>            inode,  meaning  that  (a)  the  thread has the CAP_SETFCAP
>>            capability in its own user namespace; and (b) the  UID  and
>>            GID  of  the  file inode have mappings in the writer's user
>>            namespace.
> 
> 
>>            ???????????????????????????????????????????????????????
>>            ?FIXME                                                ?
>>            ???????????????????????????????????????????????????????
>>            ?Does there also need to be some kind  of  credential ?
>>            ?match  between  the  file  and the namespace creator ?
>>            ?UID?                                                 ?
>>            ???????????????????????????????????????????????????????
> 
> The namespace creator UID (iow, the namespace owner) is irrelevant
> here; the capability model is somewhat inconsistent here. Normal
> capability checks that go down to cap_capable() (like ns_capable())
> grant all privileges to processes in parent namespaces that have an
> EUID that matches the owner UID of one of the intermediate namespaces,
> including the target namespace. But capable_wrt_inode_uidgid() always
> requires the caller to have the specified capability in its own
> namespace because, when operating on an inode, the concept of an
> implicit "target namespace" doesn't really exist. (For a properly
> consistent model, you'd probably need to let the caller explicity
> specify the target namespace, but then that would somewhat break the
> transparency of namespaces.) cap_convert_nscap() starts by checking
> for capable_wrt_inode_uidgid().

Okay -- I think I got this a little twisted. The point here, as far
as I can see, is that there is a credential check involved. The rule
is that from inside the user NS, you can set a VFS_CAP_REVISION_3
only on a file whose (mapped) UID matches the UID 0 of the namespace.
Have I got that right?

> [...]
>>        As with a binary that has VFS_CAP_REVISION_2 file capabilities,
>>        a  binary  with  VFS_CAP_REVISION_3  file  capabilities confers
>>        capabilities to a process during execve().  However,  capabili?
>>        ties  are conferred only if the binary is executed by a process
>>        that resides in a user namespace whose UID 0 maps to  the  root
>>        user  ID  that is saved in the extended attribute, or when exe?
>>        cuted by a process that resides in descendant of such a  names?
> 
> Nit: "in a descendant"?

Thanks. Fixed.

> [...]
>>>> Likewise,
>>>> +.BR getxattr(2)
>>>> +results will be converted and simplified to show a VFS_CAP_REVISION_2
>>>> +extended attribute, if a VFS_CAP_REVISION_3 applies to the caller's
>>>> +namespace, or to map the VFS_CAP_REVISION_3 root user ID into the
>>>> +caller's namespace.
>>
>> I haven't captured that last paragraph in my text. I'm not sure I
>> understand the idea being presented. Serge, could you elaborate?
> 
> Summary: When you read a capability attribute with getxattr(), the
> kernel will rewrite the returned value such that it looks the way it
> would have to look if the filesystem was mounted in your user
> namespace; just like how, when the attribute is written, the caller
> provides an attribute value written as if the filesystem was mounted
> in the caller's user namespace.
> Conceptually, this is mostly the same as the UID conversions applied
> by chown() and stat().

Okay -- thanks. I got this now. I'll work some text into the page.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
