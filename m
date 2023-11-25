Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Yz13kbqG"
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C22AA
	for <linux-security-module@vger.kernel.org>; Sat, 25 Nov 2023 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700931094; bh=2lBqQLWpTQe7NqSJl34yMkEV8/1boiKY6Wi6ZQw0KJY=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=Yz13kbqGSK85gywHQiPODk8Lbc1CFJB3clOT6u7DxRKBRKTpQwRG+faFt57TJ0cy/qD8pZryN/bMsWYCP3kDhw3Uk06pFRb2f4mA9DH8XbPVW/ULiMNEcqQSPdtpSjSjE820HqipsE/P3rfPrQ2jePxDajUKA60sw3J/7LpCdvNMP0rp2wfOOm6JOhwlbtStbCNg62Dei06jXst9EgM0hNMlKkJ/jveshQKvG7iicm+N4UvZMBydK9G6LOIETZ4Q1qbA83+pLTKGUXxSyNpelpEkgshGrNLsk01WoUCYCsg8RVqtKmQj60JcE0jjIjB2G4iYn4Dk3wiWSpLKySHs/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700931094; bh=tLf5HneFzVen8rwci0a/PWy0hEsJSXqGi52Gj0CDsbN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LmV370p7wnyL+AILsPqN1dARh95oVMLGEldqVwput3KwwuRQMAs4XqgxKk3zWPB6xpO7Vd5oD86HC/wYflt5pUYdd6Jd3pvkOmHMClo6oVgqpX/3LWIF1kGIGAW6bq/Kk7zfoCmGN6/YgZ1D95lhar4aGm396vYUYNyr2GnoB4z7ZWSIQczQRSWcuxaqyeCV5Mq/ua7siC+pJ8XWWtr1ux054xTQ0IVaIi1JUeTITvEjfitr4OQkwSoTMR9jC+2jY2BIJ8uO9sSTG3er7X4qietObD09e4MVyvTmH5/mzHTBN4ytPAKqAnckThbjhe3TE6GMle8prDdXKXel78D7vQ==
X-YMail-OSG: szdxY6QVM1nJd5l.x.5m16ZZfvMEFdyC479BmtfnP8dJDGFazDPrGC1dKgx2WsT
 S3sRMxkYVa_SmFUGPizr7yDVHyTSSCgutnGvJnOr56Kk31mw2XAnt..uCfh_bClvRDVa0girizrV
 rQiCjFqz8GlzPT2OL0YFjRIw5mRckbvCwFoH3gA_WdgCEZg0qppdV02ERHUDtIoc_SRnFF6kBeQE
 UAhShKbaB0ALyDA5CO7tGor56GH_ElZd84e0SfoQ7poZxIIkogI0E5DN1zNwUXS4IKh0zY28plaU
 uyEKz_xjJ45LSCJyIJR9kjFvCGunvYtgIXi9G7Iqy22uVLpCreeDAAwiskNH2_dUrsYBxAnLQYVX
 BMuO9YSzvyZafM1Y_9D7YQVsZD7EOJAQe8oTWBsE9MPH16hVDjYiHVzm2xQf368PfqU4L4joKVUk
 tQdQTNWxX0oqzZdAfpNNxqcMrHZOffX8q31FC6ChZEy2XVBf_VBtJdqn2nnFX11Ddhab6xrsQn57
 BFL4XXC228AghM.T9NvhRSXqyf833BqboromORLOWNLdHypiCjbxvZlLVcnokYBXJ9W367J0ctmC
 _m6sHsLrKcdFOFHsIhXporMUFRfmFzAaZU1Ff31TazTc7CY_yxnKZwMEv7CMxHIkUqdclFqaeGwZ
 hIkVUCfj8D204J1ytihUWHvoRrEOFmrnRKFuoXc_lGenQB5CmPNNcwtJNUNvTYUdQB6MVbS24t.5
 TrefUHmF5AkiM9oFgbKGJ046Po9YEsaFuSdZqSv1JMlrkVqTR1Y0FQnjv3w3..l7KTY66ToVK9qa
 uWHQ5C5mOKGq9npy6mInKhaTyhHNpapUez9wadfOPJ0O53k80bkWH0QewjzuCMtN2cOS0cZ_37ln
 oZbTx_rSm29E_lqbDcRpkK5QHq7FaucwX.FR8G_jIROKj2mYJ3t9yPXcVkpct_BFCKd8wTZQ6N2M
 NgHFGE70SWsCXwNyE65rC2d5CRtWGUZ.oW.QkieyXtLha0.iK71_D1qzcNcsx.2wV7fNrMIqf7Cc
 CjwOK2UUUSrigxEhMSfS2ILNeS00DIXKDH9JSF.yR5YxRk8tEB4dWUEaf4NkayEccQgxrwoXG_sU
 EaJJIFubF9iOh_IZQePQna30pInq9ngNV6FL1yzVWtN8UeV82yqAeWdcDxJxIM_YavbM_dwEFegx
 s1xhKeWirXB9uoKrFojH8GKITi2VZcW_jSTsnURQF.BQeRn5teZXSws4FcHr.wwpNCyo815jLyu.
 fHDThFDQUtlxJiIHcTgDV8vxQfVl5nDFBbAwzp2UbqZsY7a4563ciKL88f5uBuxKXPvV905MyXXo
 Pu91C2TBOCt6Pp9shGDqL7aR1_srDyWNe_SGk0m7nyL3tnpcThezu..8iTceleCltSEf_mMWJ23E
 vAsEhRiuN5lZ4ieETaBkHhNtdmMXRFkZymq1JNjT5lRRZ.n0w.7dSv14Yb5T30wlFP6NZ79RLDhv
 PGPvGekMw9kvJ5.QN_woOin3AoFmW19LEg9V1Q_WlMhL2SMdNVKhmD_DAOA1GDw4TkRHmgxXGTpY
 khd8Tvmxs6ldP9KYkkzFGaV.R.eo3XphtXCEeeIDhMvKrx5cquZ2CY4mqzvyd9NbNBl4MoLjkSbh
 nz3GwcuncY7sefRgblCceieKMULwJupSFYwbtkYv9Uq9fOnPNEQGbeM640UBEX2LAZxDsRfqtlMF
 lZxC4q8asXE512ky1Ze.lfcik0mktaGwIy98fD0PirGP2p0BpLAmO2hpQlS0H7dMzM6AZfWNKyO.
 9o8vHDWMAdjwVIOk4uj.ShiXanIJbZ5AxBANVdRapQclow__KkwsL8CL7mqjOoqYKi1pkoSObV9z
 wBfCcflWTI9SZx95BJVtWmYMNrhjf1xGXWswAYNoUmuQuChNX1kD0lT8VIfLbC.2ZQrZmugW_pnN
 mm7a2233J3rnNLsPuhFBh_azVcNNlm21w7VbEnB6aFiHCEKATRNM5cOcv0fXvElrnfE3BqjOdD57
 jQtOu25ah8_U9aHl9otZLjRa0Pv9l5Fao.KMoRdtUxDs78IyWSzSydOIGupZ1VJmqYBwzvGuQM2x
 csa0KT32qMf.V1l6MkeHlp8bWJI_1EAKsEv.wXwYJlXTMxBI8v2Sym9CkOzYZHDnMqiP9HN1pqtV
 TfL7sARNTrQYkyKhkYQd_j0K5eV4q7eLWB3vkypWJ8IrbmQkH1anVzaptQfnxvcUxmcicf0fxJY_
 0YRt1pOy5Q5jXT7QImir.AdRizxfpQ8lcaoToibc8oRy68RRpEaRz0UjyjvOqipSv1xkjKQzRmzD
 5UfRJ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 70ccaf9c-ee13-4ff1-9424-f7ea2321cafa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 25 Nov 2023 16:51:34 +0000
Received: by hermes--production-gq1-6775bfb8fc-xtljc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 58a8f4e5c3b7618e91e9a22be7eddaa9;
          Sat, 25 Nov 2023 16:51:31 +0000 (UTC)
Message-ID: <9afe7c6e-5753-407a-bdeb-84c0d3735b49@schaufler-ca.com>
Date: Sat, 25 Nov 2023 08:51:29 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: remove the LSM_ID_IMA check in
 lsm/lsm_list_modules_test
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
References: <20231122160742.109270-2-paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231122160742.109270-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/22/2023 8:07 AM, Paul Moore wrote:
> The IMA LSM ID token was removed as IMA isn't yet a proper LSM, but
> we forgot to remove the check from the selftest.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202311221047.a9Dww3vY-lkp@intel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  tools/testing/selftests/lsm/lsm_list_modules_test.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> index 445c02f09c74..9df29b1e3497 100644
> --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -101,9 +101,6 @@ TEST(correct_lsm_list_modules)
>  		case LSM_ID_TOMOYO:
>  			name = "tomoyo";
>  			break;
> -		case LSM_ID_IMA:
> -			name = "ima";
> -			break;
>  		case LSM_ID_APPARMOR:
>  			name = "apparmor";
>  			break;
