From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 28 Nov 2017 16:35:17 -0500
Subject: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
In-Reply-To: <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
References: <20171026084055.25482-1-mjg59@google.com>
	<20171026084055.25482-2-mjg59@google.com>
	<1511902135.3473.5.camel@linux.vnet.ibm.com>
	<CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
Message-ID: <1511904917.3473.15.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-11-28 at 13:22 -0800, Matthew Garrett wrote:
> On Tue, Nov 28, 2017 at 12:48 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Hi Matthew,
> >
> > On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett wrote:
> > > The existing BPRM_CHECK functionality in IMA validates against the
> > > credentials of the existing process, not any new credentials that the
> > > child process may transition to. Add an additional CREDS_CHECK target
> > > and refactor IMA to pass the appropriate creds structure. In
> > > ima_bprm_check(), check with both the existing process credentials and
> > > the credentials that will be committed when the new process is started.
> > > This will not change behaviour unless the system policy is extended to
> > > include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> > > credentials that it did previously.
> >
> > < snip >
> >
> > > @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> > >               case LSM_SUBJ_USER:
> > >               case LSM_SUBJ_ROLE:
> > >               case LSM_SUBJ_TYPE:
> > > -                     security_task_getsecid(tsk, &sid);
> > > +                     security_cred_getsecid(cred, &sid);
> > >                       rc = security_filter_rule_match(sid,
> > >                                                       rule->lsm[i].type,
> > >                                                       Audit_equal,
> >
> > Based on the patch description, I wouldn't expect to see any changes
> > here, unless this is wrong to begin with.  In which case, it should be
> > a separate patch.
> 
> We need to check against the appropriate credentials structure, and
> since we're doing this before commit_creds() has been called we can't
> just do it against the one in the task structure.  For BPRM_CHECK
> that'll be current_cred(), which means there's no change in
> functionality, whereas for CREDS_CHECK it'll be the new credentials
> structure.

The existing code calls security_task_getsecid() with "current" not
"current_cred". ?Will replacing security_task_getsecid() with
security_cred_getsecid() return the same info for the original
BRPM_CHECK?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
