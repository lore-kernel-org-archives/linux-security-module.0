From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Mar 2017 14:49:43 -0600
Subject: isolate selinux_enforcing
In-Reply-To: <347f63b5-c274-c7bc-55f7-f6304d31418a@schaufler-ca.com> (Casey
	Schaufler's message of "Thu, 9 Mar 2017 08:39:10 -0800")
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
	<b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com>
	<58736B2E.90201@huawei.com> <58C11A6C.7000408@huawei.com>
	<347f63b5-c274-c7bc-55f7-f6304d31418a@schaufler-ca.com>
Message-ID: <87innidvko.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 3/9/2017 1:03 AM, yangshukui wrote:
>> I want to use SELinux in system container and only concern the function in the container.
>> this system container run in vm and every vm has only one system container.
>>
>> How do I use now?
>> docker run ... system-contaier /sbin/init
>> after init is running ,the following service is also running:
>>
>> #this is the part of service file which will run in container after starting the container.
>> ..
>> semodule -R     #use the policy in container.
>> restorecon /     #if needed
>> ..
>>
>> this method seem to work if host os and the docker images use the same content for rootfs, but if host use
>> redhat7 and docker images use centos7, it will deny many normal operations , and this let some host service not work.
>>
>> If SELinux is permissive in host and enforcing in container ,it will resolve my problem. Unfortunately,
>> there is no namespace for SELinux.

This is mostly a SELinux problem.

> The LSM infrastructure is essentially a set of lists.
> These lists are rooted globally, but there's no reason*
> they couldn't be rooted in a namespace. That would give
> each namespace the option of using whatever security
> scheme was deemed appropriate. There are a number of
> issues, such as namespacing policy, that would have to
> be addressed, but the mechanism could work fine. I would
> look at patches.

>
> ---
> * Other than the sheer insanity of making security
>   claims about such a system. I would not expect that
>   minor issue to slow demand or deployment any more
>   than it has in the past.

I would tend to insist that the container local policy stacks inside the
global policy.  So that at the least the global security claims would
not be reduced.

My expectation is that a container would run as essentially all one
label from a global perspective.

To implement this would require a revision on the selinux labels xattrs
so that they can be marked as being part of a container...  But having
the labels look ordinary inside the container.

We almost have a patch that implements something like that for the
capability xattr.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
