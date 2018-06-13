From: paul@paul-moore.com (Paul Moore)
Date: Wed, 13 Jun 2018 17:22:17 -0400
Subject: [-next PATCH] security: use octal not symbolic permissions
In-Reply-To: <1adae238-44cc-83f5-538a-1b9c12916875@schaufler-ca.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
	<fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
	<alpine.LRH.2.21.1806130631400.13763@namei.org>
	<CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
	<3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
	<CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
	<00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
	<CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com>
	<38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
	<CAHC9VhRX7Vx9_FB69EgxLypo1SnA9bobtxeLn8KzuHEN8CSaNA@mail.gmail.com>
	<1adae238-44cc-83f5-538a-1b9c12916875@schaufler-ca.com>
Message-ID: <CAHC9VhRmoUsuS4S9UxFSuE7qgvX1yhhnGfd2U8Foe75unymaRw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 13, 2018 at 5:14 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 6/13/2018 12:57 PM, Paul Moore wrote:
>> On Wed, Jun 13, 2018 at 3:30 PM, Joe Perches <joe@perches.com> wrote:
>>> On Wed, 2018-06-13 at 12:19 -0400, Paul Moore wrote:
>>>> On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
>>>>> On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
>>>>>> On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
>>>>>>> On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:

...

>>> If James is not approving or merging security/selinux or
>>> security/tomoyo then perhaps the F: entries could be
>>> augmented with appropriate X: entries or made specific
>>> by using specific entries like:
>>>
>>> F:      security/*
>>> F:      security/integrity/
>>> F:      security/keys/
>
> There are already F: entries for security/selinux, security/smack
> and security/apparmor so I don't get your point.

Perhaps I've interpreted this the wrong way, but I took this to mean
that those security subsystems which don't flow through James should
use the X: entry to exclude themselves.  For example, here is a quick
diff to exclude SELinux:

diff --git a/MAINTAINERS b/MAINTAINERS
index c13b9fb3be0b..dc0b31121459 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12771,6 +12771,7 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/g>
W:     http://kernsec.org/
S:     Supported
F:     security/
+X:     security/selinux/

SELINUX SECURITY MODULE
M:     Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
