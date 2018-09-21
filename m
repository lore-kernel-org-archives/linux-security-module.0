From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 17:37:18 -0700
Subject: [PATCH security-next v2 18/26] LSM: Build ordered list of ordered
	LSMs for init
In-Reply-To: <d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org>
	<20180920162338.21060-19-keescook@chromium.org>
	<d12fc06e-ff16-63c9-34ba-7303205b0a1d@schaufler-ca.com>
Message-ID: <CAGXu5jJRHN6hMwk49Ss8knSX4CJa0UkWe0pPMHbnFGwECjo_rw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 20, 2018 at 5:04 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>> This constructs a list of ordered LSMs to initialize, using a hard-coded
>> list of only "integrity": minor LSMs continue to have direct hook calls,
>> and major LSMs continue to initialize separately.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Do you think that this mechanism will be sufficiently
> flexible to accommodate dynamically loaded security modules
> in the future? While I am not personally an advocate of
> dynamically loaded security modules I have been working to
> ensure that I haven't done anything that would actively
> interfere with someone who did.

I don't think it does, no. This is all just the boot time
initialization order, so a dynamic LSM would be unchanged: it would
initialize at module load time. :)

-Kees

-- 
Kees Cook
Pixel Security
