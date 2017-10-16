From: mjg59@google.com (Matthew Garrett)
Date: Mon, 16 Oct 2017 14:20:11 -0700
Subject: [PATCH 2/2] IMA: Support using new creds in appraisal policy
In-Reply-To: <20171017000303.46e56b42@totoro>
References: <20171016203709.11199-1-mjg59@google.com>
	<20171016203709.11199-2-mjg59@google.com>
	<20171017000303.46e56b42@totoro>
Message-ID: <CACdnJusGBTLVDtc4h3ycgZsFBhA8Ly2HZ559iPTOAOP9vZrnyg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Oct 16, 2017 at 2:03 PM, Mikhail Kurinnoi
<viewizard@viewizard.com> wrote:
> ? Mon, 16 Oct 2017 13:37:09 -0700
> Matthew Garrett <mjg59@google.com> ?????:
>>  #define IMA_BPRM_APPRAISED   0x00002000
>>  #define IMA_READ_APPRAISE    0x00004000
>>  #define IMA_READ_APPRAISED   0x00008000
>> +#define IMA_CREDS_APPRAISE   0x00004000
>> +#define IMA_CREDS_APPRAISED  0x00008000
>
> Is this correct, that the IMA_CREDS_APPRAISE and IMA_CREDS_APPRAISED
> same as IMA_READ_APPRAISE and IMA_READ_APPRAISED?

Definitely not correct, good catch. I'll resend with that fixed if
people feel this approach is reasonable.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
