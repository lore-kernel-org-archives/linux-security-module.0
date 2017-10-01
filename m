From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 01 Oct 2017 17:11:58 -0500
Subject: [RFC][PATCH] security: Make the selinux setxattr and removexattr
	hooks behave
In-Reply-To: <fa55814b-469d-65a5-16dc-3641614b8a18@schaufler-ca.com> (Casey
	Schaufler's message of "Sun, 1 Oct 2017 11:52:29 -0700")
References: <87tvzmqwoi.fsf@xmission.com>
	<1913d5c4-64ef-36c1-e8ad-c779ff5c7995@schaufler-ca.com>
	<1506694737.5571.9.camel@tycho.nsa.gov>
	<6f293107-6ff9-c4c7-f682-207a546c5061@schaufler-ca.com>
	<87vak0ma00.fsf@xmission.com>
	<db1c58f3-5a01-5276-eba7-5aac7cdcbcf5@schaufler-ca.com>
	<87d167ncms.fsf@xmission.com>
	<bf18e641-91ed-0d75-f514-c059b5dfbb14@schaufler-ca.com>
	<87tvzjllyu.fsf@xmission.com>
	<fa55814b-469d-65a5-16dc-3641614b8a18@schaufler-ca.com>
Message-ID: <87a81ajz69.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 9/30/2017 6:02 PM, Eric W. Biederman wrote:
>> I don't have a smack configuration handy, but reading through
>> the code smack setxattr the permission checks for all xattrs
>> that are not smack xattrs to cap_inode_setxattr.
>
> It's not hard to configure Smack. But, if you have a test case
> I can run it for you.

All I did was take /bin/ping from a RHEL or equally a fedora code base
where it is setcap, and copied it with rsync as root in a user namespace
and looked at the xattr.

>From memory:
$ cd
$ unshare -Ur
# rsync -Xp /bin/ping ping

>> So smack and commoncap combined will not fail.
>>
>> smack and selinux will result in people who should be able to set
>> selinux xattrs not being able to.  That however is less of an immediate
>> problem.
>
> That's not currently a problem as you can't configure
> them both to be enabled.

Like I said not immediate.

> You clearly don't work in security is running into a brick
> wall is a shocking experience :)

The shock was that the security code was so b0rked.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
