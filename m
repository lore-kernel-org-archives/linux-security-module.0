From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Fri, 25 Aug 2017 18:07:13 -0700
Subject: [PATCH net-next v7 01/10] selftest: Enhance kselftest_harness.h
	with a step mechanism
In-Reply-To: <0e15da13-fad0-ba01-053c-1b4853e2bd6f@digikod.net>
References: <20170821000933.13024-1-mic@digikod.net>
	<20170821000933.13024-2-mic@digikod.net>
	<20170824023105.gt6lyn2snhczryik@ast-mbp>
	<0e15da13-fad0-ba01-053c-1b4853e2bd6f@digikod.net>
Message-ID: <20170826010711.dksmgg4mcni5q2xd@ast-mbp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 25, 2017 at 09:58:33AM +0200, Micka?l Sala?n wrote:
> 
> 
> On 24/08/2017 04:31, Alexei Starovoitov wrote:
> > On Mon, Aug 21, 2017 at 02:09:24AM +0200, Micka?l Sala?n wrote:
> >> This step mechanism may be useful to return an information about the
> >> error without being able to write to TH_LOG_STREAM.
> >>
> >> Set _metadata->no_print to true to print this counter.
> >>
> >> Signed-off-by: Micka?l Sala?n <mic@digikod.net>
> >> Cc: Andy Lutomirski <luto@amacapital.net>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Cc: Will Drewry <wad@chromium.org>
> >> Link: https://lkml.kernel.org/r/CAGXu5j+D-FP8Kt9unNOqKrQJP4DYTpmgkJxWykZyrYiVPz3Y3Q at mail.gmail.com
> >> ---
> >>
> >> This patch is intended to the kselftest tree:
> >> https://lkml.kernel.org/r/20170806232337.4191-1-mic at digikod.net
> >>
> >> Changes since v6:
> >> * add the step counter in assert/expect macros and use _metadata to
> >>   enable the counter (suggested by Kees Cook)
> >> ---
> >>  tools/testing/selftests/kselftest_harness.h   | 31 ++++++++++++++++++++++-----
> >>  tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
> >>  2 files changed, 27 insertions(+), 6 deletions(-)
> > 
> > is there a dependency on this in patches 2+ ?
> > if not, I would send this patch to selftests right away.
> > 
> > 
> 
> The Landlock tests [patch 9/10] rely on it for now.
> 
> I sent it three weeks ago:
> https://lkml.kernel.org/r/20170806232337.4191-1-mic at digikod.net
> 
> Anyway, until this patch is merged in the kselftest tree and then
> available to net-next, I'll have to keep it here.

Shuah,
could you please pick up this patch into your tree?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
