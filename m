From: mjg59@google.com (Matthew Garrett)
Date: Wed, 18 Oct 2017 13:59:53 -0700
Subject: [PATCH 2/2] IMA: Support using new creds in appraisal policy
In-Reply-To: <1508267223.4513.23.camel@linux.vnet.ibm.com>
References: <20171016203709.11199-1-mjg59@google.com>
	<20171016203709.11199-2-mjg59@google.com>
	<1508267223.4513.23.camel@linux.vnet.ibm.com>
Message-ID: <CACdnJutiK+NyD1gAT-muf74zjt7H8gqm3-xqWJYrDCQm8TPz0g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 17, 2017 at 12:07 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Mon, 2017-10-16 at 13:37 -0700, Matthew Garrett wrote:
>>               case LSM_SUBJ_TYPE:
>> -                     security_task_getsecid(tsk, &sid);
>> +                     security_cred_getsecid(cred, &sid);
>>                       rc = security_filter_rule_match(sid,
>>                                                       rule->lsm[i].type,
>>                                                       Audit_equal,
>
> By replacing the call from security_task_getsec() to
> security_cred_getsecid(), I assume you're expecting different results.
>  Will this change break existing IMA policies?

No, for BPRM_CHECK they'll use the same creds that were previously
checked. CREDS_CHECK will behave differently to BPRM_CHECK.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
