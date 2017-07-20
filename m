From: keescook@chromium.org (Kees Cook)
Date: Wed, 19 Jul 2017 18:37:17 -0700
Subject: [PATCH v3 04/15] selinux: Refactor to remove bprm_secureexec hook
In-Reply-To: <CAHC9VhQJxyRF4f1vX6+00uVHbn8DJDBRLPyRFhU4SBQKGcgQMw@mail.gmail.com>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-5-git-send-email-keescook@chromium.org>
	<CAHC9VhTLP7kpJW65y_csgnc9hvp8ouB36U2WPyHGYgGtq8M4hg@mail.gmail.com>
	<CAHC9VhQJxyRF4f1vX6+00uVHbn8DJDBRLPyRFhU4SBQKGcgQMw@mail.gmail.com>
Message-ID: <CAGXu5j+ayWRKxn5EneOAJO-XXTo2qsxo-nwKLtjoM60_H6PFOA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 19, 2017 at 5:19 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jul 19, 2017 at 8:03 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Tue, Jul 18, 2017 at 6:25 PM, Kees Cook <keescook@chromium.org> wrote:
>>> The SELinux bprm_secureexec hook can be merged with the bprm_set_creds
>>> hook since it's dealing with the same information, and all of the details
>>> are finalized during the first call to the bprm_set_creds hook via
>>> prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
>>> via bprm->called_set_creds).
>>>
>>> Here, the test can just happen at the end of the bprm_set_creds hook,
>>> and the bprm_secureexec hook can be dropped.
>>>
>>> Cc: Paul Moore <paul@paul-moore.com>
>>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>  security/selinux/hooks.c | 24 +++++-------------------
>>>  1 file changed, 5 insertions(+), 19 deletions(-)
>>
>> This seems reasonable in the context of the other changes.
>>
>> Stephen just posted an AT_SECURE test for the selinux-testsuite on the
>> SELinux mailing list, it would be nice to ensure that this patchset
>> doesn't run afoul of that.
>
> Quick follow-up: I just merged Stephen's test into the test suite:
>
> * https://github.com/SELinuxProject/selinux-testsuite

Is there a quick how-to on just running the AT_SECURE test?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
