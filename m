From: keescook@chromium.org (Kees Cook)
Date: Mon, 7 Aug 2017 18:46:03 -0700
Subject: [PATCH 1/4] seccomp: Provide matching filter for introspection
In-Reply-To: <b1441a9f-acf0-3133-d70e-ea62564cc321@canonical.com>
References: <1501730353-46840-1-git-send-email-keescook@chromium.org>
	<1501730353-46840-2-git-send-email-keescook@chromium.org>
	<b1441a9f-acf0-3133-d70e-ea62564cc321@canonical.com>
Message-ID: <CAGXu5jJRFO8irmy1cYVbBUe2oR=B4MbvUZXPZVh4LjbUUto-CQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 7, 2017 at 6:03 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
>> -static u32 seccomp_run_filters(const struct seccomp_data *sd)
>> +static u32 seccomp_run_filters(const struct seccomp_data *sd,
>> +                            struct seccomp_filter **match)
>>  {
>>       struct seccomp_data sd_local;
>>       u32 ret = SECCOMP_RET_ALLOW;
>
> My version of this patch initialized *match to f here. The reason I did
> that is because if BPF_PROG_RUN() returns RET_ALLOW for all
> filters, I didn't want *match to remain NULL when seccomp_run_filters()
> returns. FILTER_FLAG_LOG nor FILTER_FLAG_KILL_PROCESS would be affected
> by this because they don't care about RET_ALLOW actions but there could
> conceivably be a filter flag in the future that cares about RET_ALLOW
> and not initializing *match to the first filter could result in a latent
> bug for that filter flag.

Very true, yes. I did intentionally adjust this because I wanted to
keep the hot path as untouched as possible.

> I'm fine with not adding the initialization since this is a hot path and
> it doesn't help any of the currently existing/planned filter flags but I
> wanted to at least mention it.

Yeah, and while I doubt I'll want to ever check "match" for RET_ALLOW,
I'll add a big comment there to explain it.

> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
