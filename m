From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 26 Mar 2018 13:24:58 -0700
Subject: [RFC PATCH 2/2] security: Add mechanism to (un)load LSMs after
	boot time
In-Reply-To: <fbe62489-42a7-6418-351a-5661de7deee3@huawei.com>
References: <cover.1522091329.git.sargun@sargun.me>
	<af077529868a212caeb822ae79d72a1ac40f17ba.1522091329.git.sargun@sargun.me>
	<fbe62489-42a7-6418-351a-5661de7deee3@huawei.com>
Message-ID: <CAMp4zn-NK4gre0cwaBnYrujVXEpA97OGzcbxqrySz=X91Lu+kQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 26, 2018 at 1:17 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
>
> On 26/03/18 22:24, Sargun Dhillon wrote:
>> This patch introduces a mechanism to add mutable hooks at the end of the
>> callback chain for each LSM hook. It allows for built-in kernel LSMs
>> to be unloaded, as well as modular LSMs to be loaded after boot-time.
>> It also does not compromise the security of hooks which are never
>> meant to be unloaded.
>
> Looking at this from the perspective of really convincing people to use
> other modules, there is a problem, imho.
>
> [...]
>
>>       /*
>>        * Register with LSM
>>        */
>> -     security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
>> +     security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
>> +                             false);
>
> Hardcoding what is (im)mutable will never satisfy everyone.
> If, instead, this decision was delegated to the kernel command line, it
> would be possible to have any module to become immutable -or not-
> depending on the default values and the configuration received at boot.
>
> A distro could ship with its defaults and then any user could
> reconfigure it, without having to recompile or install anything, just
> editing the command line.
>
> --
> igor
Today, the only "mutable" module we have is SELinux. It has a kernel
config flag which determines if it is unloadable (mutable) or not. If
you look at the patchset, it, in fact, sets mutability based on that
config flag:


-       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
+                               IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));

Similarly, modules can change this behaviour based on their own
choices, whether that be config flags, boot parameters, or similar. In
my opinion, most LSMs should never be unloadable. In fact, we don't
really have a safe way (in this patchset) to unload the security
modules' code safely. Doing this would either require usage of (s)rcu,
or a similar concurrency control mechanism.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
