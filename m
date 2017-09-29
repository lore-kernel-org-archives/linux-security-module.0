From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 29 Sep 2017 08:46:21 -0700
Subject: [RFC][PATCH] security: Make the selinux setxattr and removexattr
	hooks behave
In-Reply-To: <1506694737.5571.9.camel@tycho.nsa.gov>
References: <87tvzmqwoi.fsf@xmission.com>
	<1913d5c4-64ef-36c1-e8ad-c779ff5c7995@schaufler-ca.com>
	<1506694737.5571.9.camel@tycho.nsa.gov>
Message-ID: <6f293107-6ff9-c4c7-f682-207a546c5061@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/29/2017 7:18 AM, Stephen Smalley wrote:
> On Thu, 2017-09-28 at 18:16 -0700, Casey Schaufler wrote:
>> On 9/28/2017 3:34 PM, Eric W. Biederman wrote:
>>> It looks like once upon a time a long time ago selinux copied code
>>> from cap_inode_removexattr and cap_inode_setxattr into
>>> selinux_inode_setotherxattr.??However the code has now diverged and
>>> selinux is implementing a policy that is quite different than
>>> cap_inode_setxattr and cap_inode_removexattr especially when it
>>> comes
>>> to the security.capable xattr.
>> What leads you to believe that this isn't intentional?
>> It's most likely the case that this change occurred as
>> part of the first round module stacking change. What behavior
>> do you see that you're unhappy with?
>>
>>> To keep things working
>> Which "things"? How are they not "working"?
>>
>>> ?and to make the comments in security/security.c
>>> correct when the xattr is securit.capable, call cap_inode_setxattr
>>> or cap_inode_removexattr as appropriate.
>>>
>>> I suspect there is a larger conversation to be had here but this
>>> is enough to keep selinux from implementing a non-sense hard coded
>>> policy that breaks other parts of the kernel.
>> Specifics, please. Since I can't guess what problem you've
>> encountered I can't tell if it's here, in the infrastructure,
>> or in your perception of what constitutes "broken".
>>
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>> ?security/selinux/hooks.c | 6 ++++++
>>> ?1 file changed, 6 insertions(+)
>>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index f5d304736852..edf4bd292dc7 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -3167,6 +3167,9 @@ static int selinux_inode_setxattr(struct
>>> dentry *dentry, const char *name,
>>> ?	u32 newsid, sid = current_sid();
>>> ?	int rc = 0;
>>> ?
>>> +	if (strcmp(name, XATTR_NAME_CAPS) == 0)
>>> +		return cap_inode_setxattr(dentry, name, value,
>>> size, flags);
>>> +
>> No. Don't even think of contemplating considering embedding the cap
>> attribute check in the SELinux code. cap_inode_setxattr() is called
>> in
>> the infrastructure.
> Except that it isn't, not if any other security module is enabled and
> implements those hooks, to prevent imposing CAP_SYS_ADMIN checks when
> setting security.selinux or security.SMACK*.

OK. Yes, this bit of the infrastructure is some of the
worst I've done in a long time. This is a case where we
already need special case stacking infrastructure. It looks
like we'll have to separate setting the cap attribute from
checking the cap state in order to make this work. In any
case, the security_inode_setxattr() code is where the change
belongs. There will likely be fallout changes in the modules,
including the cap module.
?

> An alternative approach to fixing this would be to change the cap
> functions to only apply their checks if setting the capability
> attribute and defer any checks on other security.* attributes to either
> the security framework or the other security modules.  Then the
> framework could always call all the modules on the inode_setxattr and
> inode_removexattr hooks as with other hooks.  The security framework
> would then need to ensure that a check is still applied when setting
> security.* attributes if it isn't already handled by one of the enabled
> security modules, as you don't want unprivileged userspace to be able
> to set arbitrary security.foo attributes or to set up security.selinux
> or security.SMACK* attributes if those modules happen to be disabled.

Agreed. This isn't a two line change. Grumble.

I can guess at what the problem might be, but I hate making
assumptions when I go to fix a problem. I will start looking
at a patch, but it would really help if I could say for sure
what I'm out to accomplish. It may be obvious to the casual
observer, but that description has not been applied to me very
often.

>
>> ?
>>
>>> ?	if (strcmp(name, XATTR_NAME_SELINUX))
>>> ?		return selinux_inode_setotherxattr(dentry, name);
>>> ?
>>> @@ -3282,6 +3285,9 @@ static int selinux_inode_listxattr(struct
>>> dentry *dentry)
>>> ?
>>> ?static int selinux_inode_removexattr(struct dentry *dentry, const
>>> char *name)
>>> ?{
>>> +	if (strcmp(name, XATTR_NAME_CAPS) == 0)
>>> +		return cap_inode_removexattr(dentry, name);
>>> +
>>> ?	if (strcmp(name, XATTR_NAME_SELINUX))
>>> ?		return selinux_inode_setotherxattr(dentry, name);
>>> ?
>>
>> .
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
