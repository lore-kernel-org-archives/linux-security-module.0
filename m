From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 13 Mar 2017 09:05:38 -0700
Subject: isolate selinux_enforcing
In-Reply-To: <alpine.LRH.2.20.1703131704400.3299@namei.org>
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
	<b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com>
	<58736B2E.90201@huawei.com> <58C11A6C.7000408@huawei.com>
	<347f63b5-c274-c7bc-55f7-f6304d31418a@schaufler-ca.com>
	<87innidvko.fsf@xmission.com>
	<alpine.LRH.2.20.1703131704400.3299@namei.org>
Message-ID: <64e2a668-00ef-e095-e2f9-bf100ac6dd35@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/13/2017 12:06 AM, James Morris wrote:
> On Thu, 9 Mar 2017, Eric W. Biederman wrote:
>
>> My expectation is that a container would run as essentially all one
>> label from a global perspective.
>>
> Keep in mind that a different classes of objects may have distinct 
> labeling in SELinux.  e.g. a process and a file typically have different 
> labels (say, sshd_t vs. sshd_key_t).
>
> Also, I think you will want to have the global namespace always use the 
> original security labels.  If accessing an object from outside the 
> container, the original global policy should always apply.  Really, this 
> needs to be an invariant property.
>
> I'd suggest implementing an orthogonal 2nd set of security labels which 
> are only ever used within the container.

The work that's been done for Smack namespaces

	https://lwn.net/Articles/652320

may come in handy during during your deliberations for
SELinux. Conceptually you can create aliases for your
base labels, and use those within the container. Very
much like the UID mapping of user namespaces. Labels that
don't have an alias can't be accessed within the namespace.

>> To implement this would require a revision on the selinux labels xattrs
>> so that they can be marked as being part of a container...  But having
>> the labels look ordinary inside the container.
>>
>> We almost have a patch that implements something like that for the
>> capability xattr.
> It'll be interesting to see.
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
