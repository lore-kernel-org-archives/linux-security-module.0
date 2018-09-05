From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 5 Sep 2018 10:37:27 -0700
Subject: WARNING in apparmor_secid_to_secctx
In-Reply-To: <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com>
	<CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
	<37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
	<CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
	<9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
	<4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
	<CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
	<1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
	<CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
	<b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
	<CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
	<6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
	<CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
	<CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
Message-ID: <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
> Thanks! I've re-enabled selinux on syzbot:
> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
> Now we will have instances with apparmor and with selinux.

Any chance we could get a Smack instance as well?
