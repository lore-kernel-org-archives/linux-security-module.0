From: keescook@chromium.org (Kees Cook)
Date: Wed, 19 Apr 2017 18:50:37 -0700
Subject: [PATCH net-next v6 09/11] seccomp: Enhance test_harness with an
	assert step mechanism
In-Reply-To: <df0e6143-6db3-b7aa-f239-e879455316fa@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
	<20170328234650.19695-10-mic@digikod.net>
	<CAGXu5j+D-FP8Kt9unNOqKrQJP4DYTpmgkJxWykZyrYiVPz3Y3Q@mail.gmail.com>
	<94ac6ddc-eaac-8548-f83f-826ddf05ac69@digikod.net>
	<CAGXu5jJfnA=XeUNc4eAsUvXCja725riA7Vaod=BmM2ZbXdfQ4A@mail.gmail.com>
	<df0e6143-6db3-b7aa-f239-e879455316fa@digikod.net>
Message-ID: <CAGXu5j+8CVz8vL51DRYXqOY=xc3zuKFf=PTENe88XYHzFYidUQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 19, 2017 at 3:05 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>
>
> On 20/04/2017 00:02, Kees Cook wrote:
>> On Wed, Apr 19, 2017 at 2:51 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>>>
>>> On 19/04/2017 02:02, Kees Cook wrote:
>>>> On Tue, Mar 28, 2017 at 4:46 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>>>>> This is useful to return an information about the error without being
>>>>> able to write to TH_LOG_STREAM.
>>>>>
>>>>> Helpers from test_harness.h may be useful outside of the seccomp
>>>>> directory.
>>>>>
>>>>> Signed-off-by: Micka?l Sala?n <mic@digikod.net>
>>>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>>> Cc: Kees Cook <keescook@chromium.org>
>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>> Cc: Will Drewry <wad@chromium.org>
>>>>> ---
>>>>>  tools/testing/selftests/seccomp/test_harness.h | 8 +++++++-
>>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/seccomp/test_harness.h b/tools/testing/selftests/seccomp/test_harness.h
>>>>> index a786c69c7584..77e407663e06 100644
>>>>> --- a/tools/testing/selftests/seccomp/test_harness.h
>>>>> +++ b/tools/testing/selftests/seccomp/test_harness.h
>>>>> @@ -397,7 +397,7 @@ struct __test_metadata {
>>>>>         const char *name;
>>>>>         void (*fn)(struct __test_metadata *);
>>>>>         int termsig;
>>>>> -       int passed;
>>>>> +       __s8 passed;
>>>>
>>>> Why the reduction here? int is signed too?
>>>
>>> Because the return code of a process is capped to 8 bits and I use a
>>> negative value to not mess with the current interpretation of 0 (error)
>>> and 1 (OK) for the "passed" variable.
>>>
>>>>
>>>>>         int trigger; /* extra handler after the evaluation */
>>>>>         struct __test_metadata *prev, *next;
>>>>>  };
>>>>> @@ -476,6 +476,12 @@ void __run_test(struct __test_metadata *t)
>>>>>                                         "instead of by signal (code: %d)\n",
>>>>>                                         t->name,
>>>>>                                         WEXITSTATUS(status));
>>>>> +                       } else if (t->passed < 0) {
>>>>> +                               fprintf(TH_LOG_STREAM,
>>>>> +                                       "%s: Failed at step #%d\n",
>>>>> +                                       t->name,
>>>>> +                                       t->passed * -1);
>>>>> +                               t->passed = 0;
>>>>>                         }
>>>>
>>>> Instead of creating an overloaded mechanism here, perhaps have an
>>>> option reporting mechanism that can be enabled. Like adding to
>>>> __test_metadata "bool no_stream; int test_number;" and adding
>>>> test_number++ to each ASSERT/EXCEPT call, and doing something like:
>>>>
>>>> if (t->no_stream) {
>>>>                               fprintf(TH_LOG_STREAM,
>>>>                                       "%s: Failed at step #%d\n",
>>>>                                       t->name,
>>>>                                        t->test_number);
>>>> }
>>>>
>>>> It'd be a cleaner approach, maybe?
>>>
>>> Good idea, we will then be able to use 255 steps!
>>>
>>> Do you want me to send this as a separate patch?
>>>
>>> Can we move test_harness.h outside of the seccomp directory to be
>>> available to other subsystems as well?
>>
>> Yeah, I would do two patches, and send them out separately (to shuah
>> with lkml and me in cc at least), one to move test_hardness.h into
>> some include/ directory, and then to add the new logic for streamless
>> reporting.
>>
>> Thanks!
>>
>
> Good, in which place and name would it fit better?

I've added Shuah to CC. Shuah, where should a common header file for
selftests live? Should a new "include" directory be added?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
