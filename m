From: mjg59@google.com (Matthew Garrett)
Date: Thu, 4 Jan 2018 11:17:14 -0800
Subject: [PATCH V4 2/3] IMA: Use consistent creds
In-Reply-To: <bfb721eb-6066-4440-069f-d0089426b787@schaufler-ca.com>
References: <20180103012017.7022-1-mjg59@google.com>
	<20180103012017.7022-2-mjg59@google.com>
	<cd89f3cf-b620-b098-a3db-c53f05d330bf@schaufler-ca.com>
	<CACdnJuv7ADizvK8omRJA244N65ReYqWT2HSS_T=_uV66wMZ6Sg@mail.gmail.com>
	<a1054b8f-cebf-6c4b-be08-524d948b2449@schaufler-ca.com>
	<CACdnJus+EFtxrCH7RiKMtNqhm9CqWrvv9SviC7hncFB=8g4pew@mail.gmail.com>
	<bfb721eb-6066-4440-069f-d0089426b787@schaufler-ca.com>
Message-ID: <CACdnJutPiKUTUpS6d7G0zKjrCS8hR3xy1a+Xsi2Chyj7sAvayg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jan 3, 2018 at 12:08 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/3/2018 11:44 AM, Matthew Garrett wrote:
>> If we want to be able to do something conditional on the LSM context
>> that a process is going to be executed under, *before* commit_creds()
>> is called, is there an existing way to do so? I can rework this so we
>> use the task secid for all running processes and the cred secid for
>> the not-yet-running child process, but I don't know if that's
>> sufficient to avoid problems in future.
>
> It's possible that converting all the existing calls of
> security_task_getsecid() to security_cred_getsecid() is the
> safe approach. No one is using the task blob today, and this
> would disambiguate the situation.

Ok. Should we be looking at creds or real_creds?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
