From: john.johansen@canonical.com (John Johansen)
Date: Mon, 25 Sep 2017 10:29:52 -0400
Subject: [PATCH] apparmor: initialized returned struct aa_perms
In-Reply-To: <20170915195620.1561044-1-arnd@arndb.de>
References: <20170915195620.1561044-1-arnd@arndb.de>
Message-ID: <a94bac78-769a-e8bc-9a98-83a401534935@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/15/2017 03:55 PM, Arnd Bergmann wrote:
> gcc-4.4 points out suspicious code in compute_mnt_perms, where
> the aa_perms structure is only partially initialized before getting
> returned:
> 
> security/apparmor/mount.c: In function 'compute_mnt_perms':
> security/apparmor/mount.c:227: error: 'perms.prompt' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.hide' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.cond' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.complain' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.stop' is used uninitialized in this function
> security/apparmor/mount.c:227: error: 'perms.deny' is used uninitialized in this function
> 
> Returning or assigning partially initialized structures is a bit tricky,
> in particular it is explicitly allowed in c99 to assign a partially
> intialized structure to another, as long as only members are read that
> have been initialized earlier. Looking at what various compilers do here,
> the version that produced the warning copied unintialized stack data,
> while newer versions (and also clang) either set the other members to
> zero or don't update the parts of the return buffer that are not modified
> in the temporary structure, but they never warn about this.
> 
> In case of apparmor, it seems better to be a little safer and always
> initialize the aa_perms structure. Most users already do that, this
> changes the remaining ones, including the one instance that I got the
> warning for.
> 
> Fixes: fa488437d0f9 ("apparmor: add mount mediation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've pulled this into apparmor-next


> ---
>  security/apparmor/file.c  |  8 +-------
>  security/apparmor/lib.c   | 13 +++++--------
>  security/apparmor/mount.c | 13 ++++++-------
>  3 files changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index db80221891c6..86d57e56fabe 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -227,18 +227,12 @@ static u32 map_old_perms(u32 old)
>  struct aa_perms aa_compute_fperms(struct aa_dfa *dfa, unsigned int state,
>  				  struct path_cond *cond)
>  {
> -	struct aa_perms perms;
> -
>  	/* FIXME: change over to new dfa format
>  	 * currently file perms are encoded in the dfa, new format
>  	 * splits the permissions from the dfa.  This mapping can be
>  	 * done at profile load
>  	 */
> -	perms.deny = 0;
> -	perms.kill = perms.stop = 0;
> -	perms.complain = perms.cond = 0;
> -	perms.hide = 0;
> -	perms.prompt = 0;
> +	struct aa_perms perms = { };
>  
>  	if (uid_eq(current_fsuid(), cond->uid)) {
>  		perms.allow = map_old_perms(dfa_user_allow(dfa, state));
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index 8818621b5d95..6cbc06da964c 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -318,14 +318,11 @@ static u32 map_other(u32 x)
>  void aa_compute_perms(struct aa_dfa *dfa, unsigned int state,
>  		      struct aa_perms *perms)
>  {
> -	perms->deny = 0;
> -	perms->kill = perms->stop = 0;
> -	perms->complain = perms->cond = 0;
> -	perms->hide = 0;
> -	perms->prompt = 0;
> -	perms->allow = dfa_user_allow(dfa, state);
> -	perms->audit = dfa_user_audit(dfa, state);
> -	perms->quiet = dfa_user_quiet(dfa, state);
> +	*perms = (struct aa_perms) {
> +		.allow = dfa_user_allow(dfa, state),
> +		.audit = dfa_user_audit(dfa, state),
> +		.quiet = dfa_user_quiet(dfa, state),
> +	};
>  
>  	/* for v5 perm mapping in the policydb, the other set is used
>  	 * to extend the general perm set
> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index 82a64b58041d..ed9b4d0f9f7e 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -216,13 +216,12 @@ static unsigned int match_mnt_flags(struct aa_dfa *dfa, unsigned int state,
>  static struct aa_perms compute_mnt_perms(struct aa_dfa *dfa,
>  					   unsigned int state)
>  {
> -	struct aa_perms perms;
> -
> -	perms.kill = 0;
> -	perms.allow = dfa_user_allow(dfa, state);
> -	perms.audit = dfa_user_audit(dfa, state);
> -	perms.quiet = dfa_user_quiet(dfa, state);
> -	perms.xindex = dfa_user_xindex(dfa, state);
> +	struct aa_perms perms = {
> +		.allow = dfa_user_allow(dfa, state),
> +		.audit = dfa_user_audit(dfa, state),
> +		.quiet = dfa_user_quiet(dfa, state),
> +		.xindex = dfa_user_xindex(dfa, state),
> +	};
>  
>  	return perms;
>  }
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
