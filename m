From: keescook@chromium.org (Kees Cook)
Date: Mon, 17 Sep 2018 17:59:35 -0700
Subject: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
In-Reply-To: <580f7894-14d7-c0a3-75b7-9a5f4e3af0b8@schaufler-ca.com>
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
	<CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
	<ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com>
	<CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
	<580f7894-14d7-c0a3-75b7-9a5f4e3af0b8@schaufler-ca.com>
Message-ID: <CAGXu5j+RsokzzEZ1mNThZZPSYWBp_XSejQ53JXyLRhrr6yrEJw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 17, 2018 at 5:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> If I read you correctly, "first exclusive" would suit my needs just fine.
> I like the notion of build time ordering because I hate using the boot
> command line.

Okay, excellent. I think I have enough for a v2 on this. I'll crank it out...

-Kees

-- 
Kees Cook
Pixel Security
