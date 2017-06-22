From: keescook@chromium.org (Kees Cook)
Date: Thu, 22 Jun 2017 09:56:10 -0700
Subject: [PATCH v2] Moved module init-functions into the module.
In-Reply-To: <589cbc78-2256-2334-e907-2e440f99b612@schaufler-ca.com>
References: <20170622084507.GA4025@steve.org.uk>
	<589cbc78-2256-2334-e907-2e440f99b612@schaufler-ca.com>
Message-ID: <CAGXu5jJb8vc3Og7Mk2LUYvnJT2tZ4_W3MRPetJWtUEpAGZupXg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 22, 2017 at 9:54 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 6/22/2017 1:45 AM, Steve Kemp wrote:
>> This commit moves the call to initialize the LSM modules inline
>> into the LSM-files themselves.
>>
>> This removes the need to hunt around for the setup, which was
>> something that bit me when I wrote my own (unrelated) LSM.
>>
>> Keeping LSM code in one place, including the setup of the
>> hooks seems like a sane choice.
>
> The module initialization code belongs in the module.
> The LSM infrastructure should have an absolute minimum
> of module specific information. I would rather see the
> "minor" modules (yama, loadpin) changed to use the module
> registration scheme used by the "major" modules, but that
> will require a mechanism to ensure module ordering, and
> we don't have that yet. No, don't do this.

Yeah, I agree: initialization order is important here and I don't want
to depend on the Makefile for this.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
