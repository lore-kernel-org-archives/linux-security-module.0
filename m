From: tixxdz@gmail.com (Djalal Harouni)
Date: Mon, 10 Apr 2017 21:55:54 +0200
Subject: [PATCH RFC v2 2/3] security: add the ModAutoRestrict Linux
	Security Module
In-Reply-To: <36b005c9-e550-2ee8-61b2-136628f1a05f@schaufler-ca.com>
References: <1491734530-25002-1-git-send-email-tixxdz@gmail.com>
	<1491734530-25002-3-git-send-email-tixxdz@gmail.com>
	<b483ccc8-406c-a620-9f7a-fdcbbc3fdb26@schaufler-ca.com>
	<CAEiveUeYB8jQoP9R9xSj+5dxc3cfCg46Z=C5TkfkYibDWrEbPQ@mail.gmail.com>
	<36b005c9-e550-2ee8-61b2-136628f1a05f@schaufler-ca.com>
Message-ID: <CAEiveUcKNY1p7w2drFpqtvumC6Xw-2W0QXr7Q4YW1dwtwYdnzQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 10, 2017 at 9:04 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 4/10/2017 11:27 AM, Djalal Harouni wrote:
>> On Mon, Apr 10, 2017 at 5:42 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 4/9/2017 3:42 AM, Djalal Harouni wrote:
[...]

>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -70,6 +70,7 @@ int __init security_init(void)
>>>>       capability_add_hooks();
>>>>       yama_add_hooks();
>>>>       loadpin_add_hooks();
>>>> +     modautorestrict_init();
>>> This should be modautorestrict_add_hooks() if this were
>>> a "minor" module, but as it's using a blob it is a "major"
>>> module. Either way, this is not right.
>> Do you mean that if I'm using a blob, it should go with the rest LSMs
>> in do_security_initcalls() ?
>
> Right. Today you have coincidental non-interference because
> no one else is using the task blob. As you're aware, TOMOYO
> is going to start using it, and I believe the AppArmor has
> plans for it as well. There are parts of the Smack cred blob
> that should probably go in the task blob as they aren't used
> in access decisions. I haven't looked closely enough, but that's
> possible for SELinux, too. So even though it's a new blob, the
> major/minor rules apply.
>

Ok, point taken.

Thanks!

-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
