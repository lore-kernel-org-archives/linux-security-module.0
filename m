From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 17 Sep 2018 17:00:45 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <968ac661-ad5d-c6e2-1587-971b6dceaaea@digikod.net>
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
	<3a90fe88-d74a-2c2c-c949-cabcaad2e1da@schaufler-ca.com>
	<968ac661-ad5d-c6e2-1587-971b6dceaaea@digikod.net>
Message-ID: <99de54b0-a659-a80e-0f52-8f540192a85e@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/17/2018 4:47 PM, Micka?l Sala?n wrote:
> On 9/18/18 01:30, Casey Schaufler wrote:
>> On 9/17/2018 4:20 PM, Kees Cook wrote:
>>> On Mon, Sep 17, 2018 at 4:10 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>>>> Landlock, because it target unprivileged users, should only be called
>>>> after all other major (access-control) LSMs. The admin or distro must
>>>> not be able to change that order in any way. This constraint doesn't
>>>> apply to current LSMs, though.
>> What harm would it cause for Landlock to get called before SELinux?
>> I certainly see why it seems like it ought to get called after, but
>> would it really make a difference?
> If an unprivileged process is able to infer some properties of a file
> being requested (thanks to one of its eBPF program doing checks on this
> process accesses), whereas this file access would be denied by a
> privileged LSM, then there is a side channel attack allowing this
> process to indirectly get information otherwise inaccessible.
>
> In other words, an unprivileged process should not be allowed to sneak
> itself (via an eBPF program) before SELinux for instance. SELinux should
> be able to block such information gathering the same way it can block a
> fstat(2) requested by a process.

The argument would feel a bit stronger if LSM checks happened before
the DAC checks. The opportunity to sneak a check in already exists, but
not with the tools you get with eBPF. For now at least I'll grant that
there's good reason for Landlock to go last.
