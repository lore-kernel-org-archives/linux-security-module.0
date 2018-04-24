From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 24 Apr 2018 10:13:12 -0500
Subject: [manpages PATCH] capabilities.7: describe namespaced file
	capabilities
In-Reply-To: <5a993ec6-3b6a-b71a-24c8-dfa66a1ac89f@gmail.com> (Michael
	Kerrisk's message of "Sun, 22 Apr 2018 18:46:35 +0200")
References: <20180109185218.GA21753@mail.hallyn.com>
	<CAG48ez39UyiqE539rS6RSayj4tPBfQPHPiQ=48Roi55qFJLT7g@mail.gmail.com>
	<20180116173803.GA15538@mail.hallyn.com>
	<770ed948-c807-36d8-b946-ce6f60ffbf67@gmail.com>
	<20180415192206.GA26419@mail.hallyn.com>
	<5a993ec6-3b6a-b71a-24c8-dfa66a1ac89f@gmail.com>
Message-ID: <87a7tsfxiv.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> On 04/15/2018 09:22 PM, Serge E. Hallyn wrote:
>> Quoting Michael Kerrisk (man-pages) (mtk.manpages at gmail.com):
>>> On 01/16/2018 06:38 PM, Serge E. Hallyn wrote:
>>>> Quoting Jann Horn (jannh at google.com):
>>>>> On Tue, Jan 9, 2018 at 7:52 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>>>
>>> [...]
>>>
>>>>>> +A VFS_CAP_REVISION_3 file capability will take effect only when run in a user namespace
>>>>>> +whose UID 0 maps to the saved "nsroot", or a descendant of such a namespace.
>>>>>> +.PP
>>>>>> +Users with the required privilege may use
>>>>>> +.BR setxattr(2)
>>>>>> +to request either a VFS_CAP_REVISION_2 or VFS_CAP_REVISION_3 write.
>>>>>> +The kernel will automatically convert a VFS_CAP_REVISION_2 to a
>>>>>> +VFS_CAP_REVISION_3 extended attribute with the "nsroot"
>>>>>> +set to the root user in the writer's user namespace, or, if a VFS_CAP_REVISION_3
>>>>>> +extended attribute is specified, then the kernel will map the
>>>>>> +specified root user ID (which must be a valid user ID mapped in the caller's
>>>>>> +user namespace) into the initial user namespace.
>>>>>
>>>>> Really, "into the initial user namespace"? That may be true for the
>>>>> kernel-internal representation, but the on-disk representation is the
>>>>> mapping into the user namespace that contains the mount namespace into
>>>>> which the file system was mounted, right?
>>>>
>>>> Ah, yes, it is.
>>>>
>>>>>  This would become observable
>>>>> when a file system is mounted in a different namespace than before, or
>>>>> when working with FUSE in a namespace.
>>>>
>>>> Yes it would.
>>>>
>>>> Michael, you said you were reworking it, do you mind working this into
>>>> it as well?
>>>
>>> So, I must confess that I don't really understand this piece of the
>>> conversation--neither Jann's comments nor Serge's response (Serge, are
>>> you saying Jann is right or wrong in his comments?). Perhaps this can
>> 
>> He's right.  The point is that if a filesystem is mounted by a user in
>> a non-init user namespace, then the kernel will map the specified root user ID
>> into sb->sb_user_ns, not &init_user_ns.
>> 
>>> be clarified as a response to the man page text in the other mail I
>>> just sent?
>> 
>> Yes, I'll try to do that.
>
> So, I think that I am possibly missing some background knowledge here.
> Here, I sounds to me like you are talking about mounting a block
> filesystem in a non-initial user namespace. (Have I misunderstood?)

A filesystem with backing store certainly.

> But, as I understood it, it is not possible to mount a physical
> block-based filesystem from a a non-init user namespace. Is that not
> correct? The  only types of filesystems that I'm aware of that can be
> mounted are those listed in user_namespaces(7):

With a little luck we will have completed the work to mount fuse
filesystems by the next merge window.  Currently we are short roughly
two patches needed to make that safe.

There are fuse adaptors for just about everything.  Further the design
of the vfs work is to allow block based filesystems.

Hardening a block based in-kernel filesystem to the point where it is
safe to allow it to be mounted is an entirely different matter.  But
with the completion of the fuse work it becomes a filesystem by
filesystem question.

Network filesystems where they already need to be skeptical of their
networking peer looks like it will be less of a challenge and we may see
those filesystems change first.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
