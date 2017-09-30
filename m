From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sat, 30 Sep 2017 10:01:48 -0700
Subject: [RFC][PATCH] security: Make the selinux setxattr and removexattr
	hooks behave
In-Reply-To: <87vak0ma00.fsf@xmission.com>
References: <87tvzmqwoi.fsf@xmission.com>
	<1913d5c4-64ef-36c1-e8ad-c779ff5c7995@schaufler-ca.com>
	<1506694737.5571.9.camel@tycho.nsa.gov>
	<6f293107-6ff9-c4c7-f682-207a546c5061@schaufler-ca.com>
	<87vak0ma00.fsf@xmission.com>
Message-ID: <db1c58f3-5a01-5276-eba7-5aac7cdcbcf5@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/30/2017 9:22 AM, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
>
>> On 9/29/2017 7:18 AM, Stephen Smalley wrote:
>>> On Thu, 2017-09-28 at 18:16 -0700, Casey Schaufler wrote:
>>>> On 9/28/2017 3:34 PM, Eric W. Biederman wrote:
>>>>> It looks like once upon a time a long time ago selinux copied code
>>>>> from cap_inode_removexattr and cap_inode_setxattr into
>>>>> selinux_inode_setotherxattr.??However the code has now diverged and
>>>>> selinux is implementing a policy that is quite different than
>>>>> cap_inode_setxattr and cap_inode_removexattr especially when it
>>>>> comes
>>>>> to the security.capable xattr.
>>>> What leads you to believe that this isn't intentional?
>>>> It's most likely the case that this change occurred as
>>>> part of the first round module stacking change. What behavior
>>>> do you see that you're unhappy with?
>>>>
>>>>> To keep things working
>>>> Which "things"? How are they not "working"?
>>>>
>>>>> ?and to make the comments in security/security.c
>>>>> correct when the xattr is securit.capable, call cap_inode_setxattr
>>>>> or cap_inode_removexattr as appropriate.
>>>>>
>>>>> I suspect there is a larger conversation to be had here but this
>>>>> is enough to keep selinux from implementing a non-sense hard coded
>>>>> policy that breaks other parts of the kernel.
>>>> Specifics, please. Since I can't guess what problem you've
>>>> encountered I can't tell if it's here, in the infrastructure,
>>>> or in your perception of what constitutes "broken".
>>>>
>>>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>>> ---
>>>>> ?security/selinux/hooks.c | 6 ++++++
>>>>> ?1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>>> index f5d304736852..edf4bd292dc7 100644
>>>>> --- a/security/selinux/hooks.c
>>>>> +++ b/security/selinux/hooks.c
>>>>> @@ -3167,6 +3167,9 @@ static int selinux_inode_setxattr(struct
>>>>> dentry *dentry, const char *name,
>>>>> ?	u32 newsid, sid = current_sid();
>>>>> ?	int rc = 0;
>>>>> ?
>>>>> +	if (strcmp(name, XATTR_NAME_CAPS) == 0)
>>>>> +		return cap_inode_setxattr(dentry, name, value,
>>>>> size, flags);
>>>>> +
>>>> No. Don't even think of contemplating considering embedding the cap
>>>> attribute check in the SELinux code. cap_inode_setxattr() is called
>>>> in
>>>> the infrastructure.
>>> Except that it isn't, not if any other security module is enabled and
>>> implements those hooks, to prevent imposing CAP_SYS_ADMIN checks when
>>> setting security.selinux or security.SMACK*.
>> OK. Yes, this bit of the infrastructure is some of the
>> worst I've done in a long time. This is a case where we
>> already need special case stacking infrastructure. It looks
>> like we'll have to separate setting the cap attribute from
>> checking the cap state in order to make this work. In any
>> case, the security_inode_setxattr() code is where the change
>> belongs. There will likely be fallout changes in the modules,
>> including the cap module.
>> ?
>>
>>> An alternative approach to fixing this would be to change the cap
>>> functions to only apply their checks if setting the capability
>>> attribute and defer any checks on other security.* attributes to either
>>> the security framework or the other security modules.  Then the
>>> framework could always call all the modules on the inode_setxattr and
>>> inode_removexattr hooks as with other hooks.  The security framework
>>> would then need to ensure that a check is still applied when setting
>>> security.* attributes if it isn't already handled by one of the enabled
>>> security modules, as you don't want unprivileged userspace to be able
>>> to set arbitrary security.foo attributes or to set up security.selinux
>>> or security.SMACK* attributes if those modules happen to be disabled.
>> Agreed. This isn't a two line change. Grumble.
>>
>> I can guess at what the problem might be, but I hate making
>> assumptions when I go to fix a problem. I will start looking
>> at a patch, but it would really help if I could say for sure
>> what I'm out to accomplish. It may be obvious to the casual
>> observer, but that description has not been applied to me very
>> often.
> Apologies for the delayed reply.
>
> I am looking at security_inode_setxattr.
>
> For setting attributes in the security.* the generic code in fs/xattr.c
> applies no permission checks.
>
> Each security module that implements an xattr in security.* then imposes
> it's own policy on it's own attribute.
>
> For smack the basic rule is smack_privileged(CAP_MAC_ADMIN).
> For selinux the basic rule is inode_or_owner_capable(inode).
> For commoncap the basic rule is capable_wrt_inode_uidgid(inode, CAP_SETFCAP).
>
> commoncap also applies a default policity to setting security.* xattrs.
> ns_capable(dentry->d_sb->s_userns, CAP_SYS_ADMIN).
>
> smack reuses that default policy by calling cap_inode_setxattr if it
> isn't a smack security.* xattr.
>
> selinux has what looks like an old copy of the commoncap checks for
> the security.* in selinux_inode_setotherxattr.  Testing for
> capable(CAP_SETFCAP) for security.capable and capable(CAP_SYS_ADMIN)
> for the others.
>
> With the added complication that selinux calls
> selinux_inode_setotherxattr also for the remove_xattr case.  So fixing
> this in selinux_inode_setotherxattr is not appropriate.
>
> I believe selinux also has general policy hooks it applies to all
> invocations of setxattr.
>
> So I think to really fix this we need to separate the cases of is this
> your security modules attribute from general policy checks added by the
> security modules.  Perhaps something like this for
> security_inode_setxattr:
>
> Hmm.  Looking at least ima also has the distinction between protecting
> it's own xattr writes and running generaly security module policy on
> xattr writes.
>
> int security_inode_setxattr(struct dentry *dentry, const char *name,
> 			    const void *value, size_t size, int flags)
> {
> 	int ret = 0;
>
> 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> 		return 0;
>
> 	if (strncmp(name, XATTR_SECURITY_PREFIX,
> 			sizeof(XATTR_SECURITY_PREFIX) - 1) == 0) {
> 		/* Call the security modules and see if they all return
>                  * -EOPNOTSUPP if so apply the default permission
>                  * check of ns_capable(dentry->d_sb->s_user_ns, CAP_SYS_ADMIN)
>                  * otherwise if one of the security modules supports
> 		 * this attribute (signaled by returning something other
> 		 * -EOPNOTSUPP) then set ret to that result.
>                  *
>                  * The security modules include at least smack, selinux,
> 		 * commoncap, ima, and evm.
>                  */
>                  ret = magic_inode_protect_setxattr(dentry, name, value, size);
>         }
> 	if (ret)
> 		return ret;
>
>         /* Run all of the security module policy against this setxattr call */
>         return magic_inode_policy_setxattr(dentry, name, value, size);
> }
>
> Eric

Yup, that's pretty much what I'm thinking. It's unfortunate
that the magic_ API isn't fully implemented. There's going to
be a good deal of code surgery instead. Is there an observed
problem today? This is going to have to get addressed for stacking,
so if there isn't a behavioral issue that impacts something real
I would like to defer spending significant time on it. Do you have
a case where this is not working correctly?


.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
