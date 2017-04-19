From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Apr 2017 17:02:57 -0700
Subject: [PATCH net-next v6 09/11] seccomp: Enhance test_harness with an
	assert step mechanism
In-Reply-To: <20170328234650.19695-10-mic@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
	<20170328234650.19695-10-mic@digikod.net>
Message-ID: <CAGXu5j+D-FP8Kt9unNOqKrQJP4DYTpmgkJxWykZyrYiVPz3Y3Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 28, 2017 at 4:46 PM, Micka?l Sala?n <mic@digikod.net> wrote:
> This is useful to return an information about the error without being
> able to write to TH_LOG_STREAM.
>
> Helpers from test_harness.h may be useful outside of the seccomp
> directory.
>
> Signed-off-by: Micka?l Sala?n <mic@digikod.net>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> ---
>  tools/testing/selftests/seccomp/test_harness.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/seccomp/test_harness.h b/tools/testing/selftests/seccomp/test_harness.h
> index a786c69c7584..77e407663e06 100644
> --- a/tools/testing/selftests/seccomp/test_harness.h
> +++ b/tools/testing/selftests/seccomp/test_harness.h
> @@ -397,7 +397,7 @@ struct __test_metadata {
>         const char *name;
>         void (*fn)(struct __test_metadata *);
>         int termsig;
> -       int passed;
> +       __s8 passed;

Why the reduction here? int is signed too?

>         int trigger; /* extra handler after the evaluation */
>         struct __test_metadata *prev, *next;
>  };
> @@ -476,6 +476,12 @@ void __run_test(struct __test_metadata *t)
>                                         "instead of by signal (code: %d)\n",
>                                         t->name,
>                                         WEXITSTATUS(status));
> +                       } else if (t->passed < 0) {
> +                               fprintf(TH_LOG_STREAM,
> +                                       "%s: Failed at step #%d\n",
> +                                       t->name,
> +                                       t->passed * -1);
> +                               t->passed = 0;
>                         }

Instead of creating an overloaded mechanism here, perhaps have an
option reporting mechanism that can be enabled. Like adding to
__test_metadata "bool no_stream; int test_number;" and adding
test_number++ to each ASSERT/EXCEPT call, and doing something like:

if (t->no_stream) {
                              fprintf(TH_LOG_STREAM,
                                      "%s: Failed at step #%d\n",
                                      t->name,
                                       t->test_number);
}

It'd be a cleaner approach, maybe?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
