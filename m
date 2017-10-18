From: mjg59@google.com (Matthew Garrett)
Date: Wed, 18 Oct 2017 14:01:02 -0700
Subject: [PATCH 1/2] security: Add a cred_getsecid hook
In-Reply-To: <f438abf6-de2a-847d-40fa-0b139135b97f@schaufler-ca.com>
References: <20171016203709.11199-1-mjg59@google.com>
	<f438abf6-de2a-847d-40fa-0b139135b97f@schaufler-ca.com>
Message-ID: <CACdnJuvjcYNVvLGkxcHzkZ719-rfN8yCvkzO0kdg1xiYKVAT9A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Oct 16, 2017 at 2:58 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/16/2017 1:37 PM, Matthew Garrett wrote:
>> For IMA purposes, we want to be able to obtain the prepared secid in the
>> bprm structure before the credentials are committed. Add a cred_getsecid
>> hook that makes this possible.
>
> Why do you want the secid? What are you planning to do with it?

See the following patch - IMA policy allows the admin to restrict
appraisal to executables running in specific security contexts.
However, right now the check at application execution time ends up
using the current task creds before the new creds are committed.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
