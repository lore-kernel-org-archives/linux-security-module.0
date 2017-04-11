From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Apr 2017 21:43:45 -0700
Subject: [kernel-hardening] Re: [PATCH RFC v2 1/3] LSM: Allow per LSM
	module per "struct task_struct" blob.
In-Reply-To: <CAEiveUd4Obc+YsCiO7dp3-jypbJ4vMmsBOU=Ax8yF7+6dLes0w@mail.gmail.com>
References: <1491734530-25002-1-git-send-email-tixxdz@gmail.com>
	<1491734530-25002-2-git-send-email-tixxdz@gmail.com>
	<f25edeb6-35e1-2f8c-8fd6-fd051c4e79ce@schaufler-ca.com>
	<CAEiveUeHedQAsjbS5Jj9imq28af0OuKAjMTudMJm7GqObRNMfQ@mail.gmail.com>
	<2698e97b-397e-0fc0-84a1-dc9a4226117a@schaufler-ca.com>
	<CAEiveUd4Obc+YsCiO7dp3-jypbJ4vMmsBOU=Ax8yF7+6dLes0w@mail.gmail.com>
Message-ID: <CAGXu5jL7jLid57UoXCxSqo5JZRLMgZ7X6BSYgWLckp5YpoiAmA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 10, 2017 at 1:00 PM, Djalal Harouni <tixxdz@gmail.com> wrote:
> On Mon, Apr 10, 2017 at 9:26 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> I think that would be the prudent approach. There is still
>> the possibility that blob sharing (or full stacking, if you
>> prefer) won't be accepted any time soon.
>
> Ok Casey! I will wait for more feedback, and if other maintainers do
> not object, I will convert it back to rhashtables in next iterations
> making sure that it should be simple to convert later to a blob
> sharing mechanism.

Would it be possible just to add a single field to task_struct if this
LSM is built in? I feel like rhashtables is a huge overhead when a
single field is all that's needed.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
