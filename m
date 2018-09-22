From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:50:39 -0700
Subject: [PATCH v4 08/19] Infrastructure management of the cred security
	blob
In-Reply-To: <f08b4c79-f283-3625-f461-71a4628655ef@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<f08b4c79-f283-3625-f461-71a4628655ef@schaufler-ca.com>
Message-ID: <CAGXu5jLKMG15hex6ko=E-YCMRRsmd22KdjzrRXH_FRMqwmchkw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the cred security blob out of the
> security modules and into the security infrastructre.
> Instead of allocating and freeing space the security
> modules tell the infrastructure how much space they
> require.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

When combined with my series, this gets slightly simpler:
- the double init call and the "finished" stuff goes away
- debugging output is controlled by "lsm.debug" param instead of a CONFIG

Regardless, for the overall logic, calculating the sizes, etc:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
