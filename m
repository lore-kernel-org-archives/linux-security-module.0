From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 17 Sep 2018 16:40:50 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <CAGXu5j+haqMgKxkH12M3O358oBR-jU0uWTZSrCrm462mtgf26A@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-17-keescook@chromium.org>
	<84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
	<CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
	<35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com>
	<CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
	<8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
	<CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
	<53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com>
	<7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
	<fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com>
	<e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
	<a51a4d34-7077-bfbe-5979-00e79680f514@digikod.net>
	<CAGXu5jLfCNSDWDV-MX6Kyyz3AcMBwubH8YAzZ=28xe9kwNCw4g@mail.gmail.com>
	<060150b2-4bb4-bdcb-760a-5aa5e1ade381@canonical.com>
	<CAGXu5j+haqMgKxkH12M3O358oBR-jU0uWTZSrCrm462mtgf26A@mail.gmail.com>
Message-ID: <ddb2a534-0845-55c1-329c-70adcc3847b8@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/17/2018 4:28 PM, Kees Cook wrote:
> On Mon, Sep 17, 2018 at 4:26 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/17/2018 04:20 PM, Kees Cook wrote:
>>> On Mon, Sep 17, 2018 at 4:10 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>>>> Landlock, because it target unprivileged users, should only be called
>>>> after all other major (access-control) LSMs. The admin or distro must
>>>> not be able to change that order in any way. This constraint doesn't
>>>> apply to current LSMs, though.
>>> Good point! It will be easy to add LSM_ORDER_LAST, though, given the
>>> machinery introduced in this series.
>>>
>> And when we have two LSMs that want to use that?
> We'll cross that bridge when we come to it, but perhaps "last
> exclusive"? (lsm.enable/disable to choose)

If we define restrictions on use of LSM_ORDER_LAST like we have
for LSM_ORDER_FIRST (only for capabilities) before anyone starts
abusing it we may be OK. Since an LSM_ORDER_LAST has to know that
it can't count on getting called (a non-last module may return -EACCES)
I don't see any way that having multiple LSM_ORDER_LAST modules in
any given order would be a real problem. Of course, a module could be
doing state management that *really* requires it be last, but that
would be a badly designed module and someone sensible would NAK it.
