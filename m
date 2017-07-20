From: paul@paul-moore.com (Paul Moore)
Date: Thu, 20 Jul 2017 09:42:11 -0400
Subject: [PATCH v3 04/15] selinux: Refactor to remove bprm_secureexec hook
In-Reply-To: <CAGXu5j+ayWRKxn5EneOAJO-XXTo2qsxo-nwKLtjoM60_H6PFOA@mail.gmail.com>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-5-git-send-email-keescook@chromium.org>
	<CAHC9VhTLP7kpJW65y_csgnc9hvp8ouB36U2WPyHGYgGtq8M4hg@mail.gmail.com>
	<CAHC9VhQJxyRF4f1vX6+00uVHbn8DJDBRLPyRFhU4SBQKGcgQMw@mail.gmail.com>
	<CAGXu5j+ayWRKxn5EneOAJO-XXTo2qsxo-nwKLtjoM60_H6PFOA@mail.gmail.com>
Message-ID: <CAHC9VhQRhQAbH4c5ZjdEJy-fcMz=oUrd5F4Q755AHVFZVmFR+w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 19, 2017 at 9:37 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jul 19, 2017 at 5:19 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Jul 19, 2017 at 8:03 PM, Paul Moore <paul@paul-moore.com> wrote:
>>> On Tue, Jul 18, 2017 at 6:25 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> The SELinux bprm_secureexec hook can be merged with the bprm_set_creds
>>>> hook since it's dealing with the same information, and all of the details
>>>> are finalized during the first call to the bprm_set_creds hook via
>>>> prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
>>>> via bprm->called_set_creds).
>>>>
>>>> Here, the test can just happen at the end of the bprm_set_creds hook,
>>>> and the bprm_secureexec hook can be dropped.
>>>>
>>>> Cc: Paul Moore <paul@paul-moore.com>
>>>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>>  security/selinux/hooks.c | 24 +++++-------------------
>>>>  1 file changed, 5 insertions(+), 19 deletions(-)
>>>
>>> This seems reasonable in the context of the other changes.
>>>
>>> Stephen just posted an AT_SECURE test for the selinux-testsuite on the
>>> SELinux mailing list, it would be nice to ensure that this patchset
>>> doesn't run afoul of that.
>>
>> Quick follow-up: I just merged Stephen's test into the test suite:
>>
>> * https://github.com/SELinuxProject/selinux-testsuite
>
> Is there a quick how-to on just running the AT_SECURE test?

You'll need a functional SELinux system to start, I run it against
Fedora Rawhide regularly* with various development kernels, but recent
stable Fedora releases should work too.  Occasionally I hear of people
running it on Debian, but I haven't had a Debian SELinux system in
some time so I can't say for certain everything is 100% working there.
Once you've gotten a working system in enforcing mode, read the README
file in the test suite to install the necessary dependencies (look in
the "Userland and Base Policy" section), then build the tests/policy
(you should be able to skip this step, as the make dependencies will
handle it, but it is nice to do it separately to make sure you have
the build dependencies sorted):

  # make

... load the test policy

  # make -C policy load

... run the tests:

  # cd tests/atsecure
  # ./test

... optionally uninstall the test policy:

  # make -C policy unload

In some ways it is easier to just run the entire test suite:

  # make
  # make test

Alternatively, if you've got a fairly recent git repo with all the
patches merged I can build a test kernel and give it a shot for you,
although fair warning it may take a day or two for me to get to it.

* It is worth noting that the current 4.13-rcX releases have two bugs
that affect the selinux-testsuite.  The worst is a kernel panic due to
a bug in overlayfs' xattr code, there is a patch available to fix it,
but as of yesterday it hadn't yet hit Linus tree (I can dig it up if
you need it).  The second issue related to IPsec and getting peer
label information over UDP connections, I haven't had a chance to sort
that out yet, but at least it isn't a kernel panic.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
