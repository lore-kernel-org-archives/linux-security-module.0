From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 7 Mar 2018 09:45:40 -0800
Subject: [PATCH v4 1/3] security: Refactor LSM hooks into an array and enum
In-Reply-To: <3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
References: <cover.1520407240.git.sargun@sargun.me>
	<3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
Message-ID: <ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/6/2018 11:23 PM, Sargun Dhillon wrote:
> This commit should have no functional change. It changes the security hook
> list heads struct into an array. Additionally, it exposes all of the hooks
> via an enum. This loses memory layout randomization as the enum is not
> randomized.

Please explain why you want to do this. I still dislike it.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
