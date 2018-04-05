From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 5 Apr 2018 09:29:12 -0700
Subject: [PATCH v4 0/1] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
References: <cover.1522560550.git.sargun@sargun.me>
	<911d9855-cd45-26f0-90eb-563db899d5ee@huawei.com>
	<CANA3KFX_sVhqvV7C0kR1nkLijiwWc286KcPBfY94LOe=YKGBwg@mail.gmail.com>
Message-ID: <130851a6-1801-1917-b3df-5af89d2c421b@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/5/2018 3:31 AM, Peter Dolding wrote:
> On Thu, Apr 5, 2018 at 7:55 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> On 01/04/18 08:41, Sargun Dhillon wrote:
>>> The biggest security benefit of this patchset is the introduction of
>>> read-only hooks, even if some security modules have mutable hooks.
>>> Currently, if you have any LSMs with mutable hooks it will render all heads, and
>>> list nodes mutable. These are a prime place to attack, because being able to
>>> manipulate those hooks is a way to bypass all LSMs easily, and to create a
>>> persistent, covert channel to intercept nearly all calls.
>>>
>>>
>>> If LSMs have a model to be unloaded, or are compled as modules, they should mark
>>> themselves mutable at compile time, and use the LSM_HOOK_INIT_MUTABLE macro
>>> instead of the LSM_HOOK_INIT macro, so their hooks are on the mutable
>>> chain.
>>
>> I'd rather consider these types of hooks:
>>
>> A) hooks that are either const or marked as RO after init
>>
>> B) hooks that are writable for a short time, long enough to load
>> additional, non built-in modules, but then get locked down
>> I provided an example some time ago [1]
>>
>> C) hooks that are unloadable (and therefore always attackable?)
>>
>> Maybe type-A could be dropped and used only as type-B, if it's
>> acceptable that type-A hooks are vulnerable before lock-down of type-B
>> hooks.
>>
>> I have some doubts about the usefulness of type-C, though.
>> The benefit I see htat it brings is that it avoids having to reboot when
>> a mutable LSM is changed, at the price of leaving it attackable.
>>
>> Do you have any specific case in mind where this trade-off would be
>> acceptable?
>>
> A useful case for loadable/unloadable LSM is development automate QA.
>
> So you have built a new program and you you want to test it against a
> list of different LSM configurations without having to reboot the
> system.  So a run testsuite with LSM off  then enabled LSM1 run
> testsuite again disable LSM1 enable LSM2. run testsuite disable
> LSM2... Basically repeating process.
>
> I would say normal production machines being able to swap LSM like
> this does not have much use.
>
> Sometimes for productivity it makes sense to be able to breach
> security.   The fact you need to test with LSM disabled to know if any
> of the defects you are seeing is LSM configuration related that
> instance is already in the camp of non secure anyhow..
>
> There is a shade of grey between something being a security hazard and
> something being a useful feature.

If the only value of a feature is development I strongly
advocate against it. The number of times I've seen things
completely messed up because it makes development easier
is astonishing. If you have to enable something dangerous
just for testing you have to wonder about the testing.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
