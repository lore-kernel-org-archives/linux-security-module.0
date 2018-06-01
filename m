From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 1 Jun 2018 13:55:42 +0300
Subject: [PATCH v2 13/21] ima: use match_string() helper
In-Reply-To: <1527778958.3427.16.camel@linux.vnet.ibm.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
	<1527765086-19873-14-git-send-email-xieyisheng1@huawei.com>
	<1527778958.3427.16.camel@linux.vnet.ibm.com>
Message-ID: <CAHp75Vc8Bf-aWkuZ_uzdzp5fRQDWLNSansjCsx8MOTCk21OVmg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 31, 2018 at 6:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2018-05-31 at 19:11 +0800, Yisheng Xie wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
>>
>> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: linux-integrity at vger.kernel.org
>> Cc: linux-security-module at vger.kernel.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>
> In the future, the patch's author Signed-off-by is always first.
>
> Thanks, this patch is now queued in the next-integrity branch.

Hmm... It's interesting since git commit -s checks for author's SoB as
a _last_ in the bunch.

Is it configurable?


-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
