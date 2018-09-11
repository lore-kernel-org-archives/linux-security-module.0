From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 11 Sep 2018 10:23:20 -0700
Subject: [PATCH 1/3] selinux: make dentry_init_security() return security
	module name
In-Reply-To: <CAAM7YA=Aq8NFB+CsDWhnzwG1N0Nzfby4UKy9gTTDkcp_aUxcnw@mail.gmail.com>
References: <20180626084306.27511-1-zyan@redhat.com>
	<356ec32809a222f457b4e04333bb695c32d49680.camel@kernel.org>
	<70879e33-73cd-7185-06a4-cd3147b6a53f@schaufler-ca.com>
	<CAAM7YA=baUU1dMpPZMOMrGHJ2hguLNP2tFuHHjVqVjh37eA7kA@mail.gmail.com>
	<d0acf4cd-bb79-e111-a0f0-524f8fc836fc@schaufler-ca.com>
	<CAAM7YA=Aq8NFB+CsDWhnzwG1N0Nzfby4UKy9gTTDkcp_aUxcnw@mail.gmail.com>
Message-ID: <916bc4be-360a-a2a6-c46b-452d56b58839@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/9/2018 8:06 PM, Yan, Zheng wrote:
> On Sat, Sep 8, 2018 at 4:31 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/7/2018 1:31 AM, Yan, Zheng wrote:
>>> On Thu, Sep 6, 2018 at 11:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/6/2018 8:08 AM, Jeff Layton wrote:
>>>>> On Tue, 2018-06-26 at 16:43 +0800, Yan, Zheng wrote:
>>>>>> This is preparation for CephFS security label. CephFS's implementation uses
>>>>>> dentry_init_security() to get security context before inode is created,
>>>>>> then sends open/mkdir/mknod request to MDS, together with security xattr
>>>>>> "security.<security module name>"
>>>> Please excuse my late entry into this review.
>>>>
>>>> First, *Do not prefix general LSM interface work with "selinux:"*
>>>> You should only use that prefix when you're dealing with the
>>>> internals of SELinux. Use "LSM:" if you are changing LSM interfaces.
>>>> If you are changing security.h or lsm_hooks.h you are almost
>>>> certainly changing LSM interfaces.
>>>>
>>>> Because you prefixed this work with "selinux:" I pretty much
>>>> ignored it. Please don't do that again.
>>>>
>>>> Why aren't you using security_inode_getsecctx, like kernfs and nfs?
>>>>
>>> Sorry, I don't understand why you mention security_inode_getsecctx().
>>> The selinux_dentry_init_security is called for new inode, I don't how
>>> security_inode_getsecctx() can help.
>> I didn't do a great job describing my issue. Let me try again.
>>
>> There is no way you should need to know the name of the security
>> module (e.g. SELinux, Smack) in the CephFS code. Nor should you be
>> assuming that there is only one security attribute, nor that it is
>> named "security.<security module name>".  Sure, that's true for
>> SELinux, but SELinux isn't the only security module in town.
>>
>> Other filesystems don't need anything like this. Why do you?
>>
> What I want is a way to get security context before inode is created.

What are you doing differently from the other filesystems?
Why doesn't the security_d_instantiate mechanism work for you?

> The closest interface is security_dentry_init_security(). Currently
> the only NFS uses security_dentry_init_security() and only selinux has
> dentry_init_security callback. NFS store selinux context in its
> security label (NFS inode can only have one security label, security
> label can only store one security context). SO current NFS security
> label implementation can not support multiple security modules.

That's correct. The labeled NFS is a very specific mechanism. It
does not do anything except Mandatory Access Control labeling. It
cannot be used for any other attributes. I am not a fan of the
labeled NFS implementation, and was vocal about it at the time.

> I don't want to limit cephfs to single security module. So I make
> cephfs store security context in security.<security module name>
> xattr. 

Please look at the mechanism used in kernfs.

> When multiple security modules work is done in the future,
> cephfs can easily supports it. (introduce a new
> security_dentry_init_security() which return security contexts for all
> enabled security modules)

That is easier said than done. I've proposed several mechanisms,
none of which are especially satisfactory. The best mechanism I see
is the one used in kernfs, which is why I suggest you use that.
