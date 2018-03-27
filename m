From: paul@paul-moore.com (Paul Moore)
Date: Tue, 27 Mar 2018 07:52:31 -0400
Subject: [RFC PATCH 2/2] security: Add mechanism to (un)load LSMs after
	boot time
In-Reply-To: <alpine.LRH.2.21.1803271902590.9495@namei.org>
References: <cover.1522091329.git.sargun@sargun.me>
	<af077529868a212caeb822ae79d72a1ac40f17ba.1522091329.git.sargun@sargun.me>
	<fbe62489-42a7-6418-351a-5661de7deee3@huawei.com>
	<CAMp4zn-NK4gre0cwaBnYrujVXEpA97OGzcbxqrySz=X91Lu+kQ@mail.gmail.com>
	<alpine.LRH.2.21.1803271902590.9495@namei.org>
Message-ID: <CAHC9VhTr414ZvW45kP97u2CjHqffT5JsAh=GS3Eujj_P1YcJ0w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 27, 2018 at 4:08 AM, James Morris <jmorris@namei.org> wrote:
> On Mon, 26 Mar 2018, Sargun Dhillon wrote:
>> Today, the only "mutable" module we have is SELinux. It has a kernel
>> config flag which determines if it is unloadable (mutable) or not. If
>> you look at the patchset, it, in fact, sets mutability based on that
>> config flag:
>>
>>
>> -       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
>> +       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
>> +                               IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));
>
> There has been discussion about removing the ability to unload SELinux --
> not sure what the current status of that is.

It is something I would still like to do, but there is some work that
needs to be done to allow a smooth transition for those people who are
currently disabling/unloading SELinux at runtime.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
