From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Wed, 23 Aug 2017 19:31:07 -0700
Subject: [PATCH net-next v7 01/10] selftest: Enhance kselftest_harness.h
	with a step mechanism
In-Reply-To: <20170821000933.13024-2-mic@digikod.net>
References: <20170821000933.13024-1-mic@digikod.net>
	<20170821000933.13024-2-mic@digikod.net>
Message-ID: <20170824023105.gt6lyn2snhczryik@ast-mbp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 21, 2017 at 02:09:24AM +0200, Micka?l Sala?n wrote:
> This step mechanism may be useful to return an information about the
> error without being able to write to TH_LOG_STREAM.
> 
> Set _metadata->no_print to true to print this counter.
> 
> Signed-off-by: Micka?l Sala?n <mic@digikod.net>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Link: https://lkml.kernel.org/r/CAGXu5j+D-FP8Kt9unNOqKrQJP4DYTpmgkJxWykZyrYiVPz3Y3Q at mail.gmail.com
> ---
> 
> This patch is intended to the kselftest tree:
> https://lkml.kernel.org/r/20170806232337.4191-1-mic at digikod.net
> 
> Changes since v6:
> * add the step counter in assert/expect macros and use _metadata to
>   enable the counter (suggested by Kees Cook)
> ---
>  tools/testing/selftests/kselftest_harness.h   | 31 ++++++++++++++++++++++-----
>  tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
>  2 files changed, 27 insertions(+), 6 deletions(-)

is there a dependency on this in patches 2+ ?
if not, I would send this patch to selftests right away.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
