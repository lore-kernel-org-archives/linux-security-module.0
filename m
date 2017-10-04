From: paul@paul-moore.com (Paul Moore)
Date: Wed, 4 Oct 2017 16:34:04 -0400
Subject: [PATCH 2/2] selinux: fix build warning
In-Reply-To: <1507148872.1491.11.camel@tycho.nsa.gov>
References: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
	<20171004183218.4786-2-clabbe.montjoie@gmail.com>
	<1507148872.1491.11.camel@tycho.nsa.gov>
Message-ID: <CAHC9VhQvi8TerCU+aj8=sV91PXNE6V2fmC6bwAP+4icE7OcryQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 4, 2017 at 4:27 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-10-04 at 20:32 +0200, Corentin Labbe wrote:
>> This patch make selinux_task_prlimit() static since it is not used
>> anywhere else.
>> This fix the following build warning:
>> security/selinux/hooks.c:3981:5: warning: no previous prototype for
>> 'selinux_task_prlimit' [-Wmissing-prototypes]
>>
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Merged, thanks again.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
