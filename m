From: mjg59@google.com (Matthew Garrett)
Date: Mon, 30 Oct 2017 10:54:22 +0000
Subject: [PATCH V3 1/2] security: Add a cred_getsecid hook
In-Reply-To: <ac81cfb4-5cd3-64e5-5a08-4f167696a84d@schaufler-ca.com>
References: <20171026084055.25482-1-mjg59@google.com>
	<ac81cfb4-5cd3-64e5-5a08-4f167696a84d@schaufler-ca.com>
Message-ID: <CACdnJus0bb=LcbRjHVMMjHpi+NG3YV_DwF4UBT4uSoY=tHqyTQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 2:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/26/2017 1:40 AM, Matthew Garrett wrote:
>>  V3: Fix smack_cred_getsecid()
>
> Much better. Have you tried this with Smack?

I'm afraid not - I have zero expertise with Smack and no easy way to
set it up. I can do so later in the week if you like?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
