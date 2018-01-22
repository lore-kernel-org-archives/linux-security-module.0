From: mjg59@google.com (Matthew Garrett)
Date: Mon, 22 Jan 2018 16:27:51 +1100
Subject: [PATCH V6 1/2] security: Add a cred_getsecid hook
In-Reply-To: <20180108213620.170042-1-mjg59@google.com>
References: <20180108213620.170042-1-mjg59@google.com>
Message-ID: <CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 9, 2018 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
> For IMA purposes, we want to be able to obtain the prepared secid in the
> bprm structure before the credentials are committed. Add a cred_getsecid
> hook that makes this possible.

Any feedback on this version of the set?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
