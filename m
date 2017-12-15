From: mjg59@google.com (Matthew Garrett)
Date: Fri, 15 Dec 2017 14:35:56 -0800
Subject: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
In-Reply-To: <CACdnJuu4cA0rAeejNd5hzgZZt+nAYF4-_v55Roib_oHexo2r8w@mail.gmail.com>
References: <20171026084055.25482-1-mjg59@google.com>
	<20171026084055.25482-2-mjg59@google.com>
	<1511902135.3473.5.camel@linux.vnet.ibm.com>
	<CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
	<1511904917.3473.15.camel@linux.vnet.ibm.com>
	<CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
	<1511908390.3473.30.camel@linux.vnet.ibm.com>
	<CACdnJuu4cA0rAeejNd5hzgZZt+nAYF4-_v55Roib_oHexo2r8w@mail.gmail.com>
Message-ID: <CACdnJuvwFOeOfVqYux+nw8n7qM=VLRFk6cK4HhQe13WCoHwvtA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Dec 15, 2017 at 2:24 PM, Matthew Garrett <mjg59@google.com> wrote:
> Hm, sorry, missed this mail.
>
> On Tue, Nov 28, 2017 at 2:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> On Tue, 2017-11-28 at 13:37 -0800, Matthew Garrett wrote:
>>> security_task_getsecid(current) will give the same results as
>>> security_cred_getsecid(current_creds())
>>
>> Unwinding security_task_getsecid(current) looks like it is using
>> real_cred, while current_cred() is using cred.
>
> Good question, and there's a current_real_cred() macro, so I should
> just use that instead.

Hm. Actually, I'm not sure. For most checks we were using cred, and
only using real_cred for the secid lookup. This feels somewhat
inconsistent.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
