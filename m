From: oiaohm@gmail.com (Peter Dolding)
Date: Thu, 5 Apr 2018 22:28:30 +1000
Subject: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <63eaa2d5-3662-2240-15fb-ab2227b6903a@huawei.com>
References: <cover.1522560550.git.sargun@sargun.me>
	<911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
	<CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
	<63eaa2d5-3662-2240-15fb-ab2227b6903a@huawei.com>
Message-ID: <CANA3KFWkYJ4kGjZ_9E1Qa4B=onyE5zNucPmX3RPQmcRL6esGqg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Apr 5, 2018 at 9:34 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 05/04/18 13:31, Peter Dolding wrote:
>> On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> There is a shade of grey between something being a security hazard and
>> something being a useful feature.
>
> Maybe the problem I see is only in the naming: if what right now is
> addressed as "mutable" were to be called in some other way that does not
> imply that it's impossible to lock it down, then I think there wouldn't
> be much of a problem anymore.
>
> How about s/mutable/protectable/g ?
>
> Then it could be a boot time parameter to decide if the "extra" hooks
> should be protected or stay writable, for example for performing more
> extensive testing.
>
Due to being a shades of grey area I would say kconfig 2 option and 1
boot time parameter.

Some kernels the ability to change LSM on fly should be fully disabled
in the build process.

The abplity to change LSM at runtime has limited valid usage cases so
even if the kernel is built with the ablity to change LSM at runtime
enabled it should still be off by default until enabled with boot time
parameter.   So those who need the feature turn it on and those who
don't need it on cannot turn it on just by installing a kernel.   For
systems that cannot use Linux kernel command line features to turn
stuff on and off a kernel configuration option to change the default
to on with warning in kernel configure.   So 2 kconfig entries and 1
Kernel Boot Parameter.   Of course when a feature like this is enabled
there should be a kernel message so its recorded in logs and is check
able if a feature like this that can lower security is turn on.

The ability to change LSM on fly i see the development usage cases.
I can not think of a single production system usage case for anyone
who is not a developer.   I might be thinking way to narrow.  Unless
someone else can find another use case I would suggest following what
I suggest how a feature like this is enabled.

Naming the feature what ever you think is suitable.

Peter Dolding
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
