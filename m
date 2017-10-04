From: paul@paul-moore.com (Paul Moore)
Date: Wed, 4 Oct 2017 16:33:50 -0400
Subject: [PATCH 1/2] selinux: fix build warning by removing the unused sid
	variable
In-Reply-To: <1507148778.1491.10.camel@tycho.nsa.gov>
References: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
	<1507148778.1491.10.camel@tycho.nsa.gov>
Message-ID: <CAHC9VhSNVsFzMpCEa2gmADVF4G85VZDDqfpYsOCrzbJvjRX_GQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 4, 2017 at 4:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-10-04 at 20:32 +0200, Corentin Labbe wrote:
>> This patch remove the unused variable sid
>> This fix the following build warning:
>> security/selinux/hooks.c:2921:6: warning: variable 'sid' set but not
>> used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Looks good to me too, merged into selinux/next.  Thanks.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
