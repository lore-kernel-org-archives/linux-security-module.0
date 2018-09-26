From: keescook@chromium.org (Kees Cook)
Date: Wed, 26 Sep 2018 11:35:21 -0700
Subject: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
In-Reply-To: <20180926123522.4080d9eb@vmware.local.home>
References: <20180925001832.18322-1-keescook@chromium.org>
	<20180925001832.18322-5-keescook@chromium.org>
	<20180926123522.4080d9eb@vmware.local.home>
Message-ID: <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 26, 2018 at 9:35 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 24 Sep 2018 17:18:07 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> security and console initcall trace events") since security init calls
>> are about to no longer resemble regular init calls.
>
> I'm not against the change, but how much are they going to "no longer
> resemble regular init calls"?

My take on "regular" init calls is that they're always run, link-time
ordered, etc. The changes proposed here will make it so not all
initialization are run depending on runtime configurations, ordering
will be flexible, etc.

-Kees

-- 
Kees Cook
Pixel Security
