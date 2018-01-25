From: mjg59@google.com (Matthew Garrett)
Date: Thu, 25 Jan 2018 11:58:39 +1100
Subject: [PATCH V6 1/2] security: Add a cred_getsecid hook
In-Reply-To: <8b7f9729-af09-a59e-0cd0-8db58d82ea56@schaufler-ca.com>
References: <20180108213620.170042-1-mjg59@google.com>
	<CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
	<8b7f9729-af09-a59e-0cd0-8db58d82ea56@schaufler-ca.com>
Message-ID: <CACdnJutphETV-aGj9QTN0Z=VyQYod9R7=HjQSrXDVL2ASQfOzA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jan 22, 2018 at 5:14 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/21/2018 9:27 PM, Matthew Garrett wrote:
>> On Tue, Jan 9, 2018 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
>>> For IMA purposes, we want to be able to obtain the prepared secid in the
>>> bprm structure before the credentials are committed. Add a cred_getsecid
>>> hook that makes this possible.
>> Any feedback on this version of the set?
>
>
> Sorry for the delay. I'm having a mindset crisis on secids just
> now, and I'm not completely sure if I have any issue with this
> particular hook. Don't wait for me. If everyone else is OK with
> it, go ahead.

Thanks Casey - Mimi, are you ok with the IMA changes? If so, which
tree should these go through?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
