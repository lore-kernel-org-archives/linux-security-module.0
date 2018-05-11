From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 11 May 2018 09:09:04 -0700
Subject: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
	'limit_pids=1' mount option
In-Reply-To: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
Message-ID: <7c638a92-8c40-fa15-8c63-777232588137@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/11/2018 02:36 AM, Alexey Gladkov wrote:
> From: Djalal Harouni <tixxdz@gmail.com>
> 
> If "limit_pids=1" mount option is set then do not instantiate pids that
> we can not ptrace. "limit_pids=1" means that procfs should only contain
> pids that the caller can ptrace.

Where can I find documentation on these mount options (pidonly, limit_pids)?

Thanks.

> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
> ---
>  fs/proc/base.c | 9 +++++++++
>  1 file changed, 9 insertions(+)


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
