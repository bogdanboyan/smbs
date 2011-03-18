CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_person` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_account` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kind_of` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'business',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `asset_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asset_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asset_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asset_file_size` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `asset_files_mobile_campaigns` (
  `mobile_campaign_id` int(11) DEFAULT NULL,
  `asset_file_id` int(11) DEFAULT NULL,
  KEY `index_mobile_campaign_id_and_asset_file_id` (`mobile_campaign_id`,`asset_file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `bar_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `origin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` mediumtext COLLATE utf8_unicode_ci,
  `version` int(11) DEFAULT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bar_codes_on_id_and_type` (`id`,`type`),
  KEY `index_bar_codes_on_account_id` (`account_id`),
  KEY `index_bar_codes_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'unpublished',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `display` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_cities_on_region_id` (`region_id`),
  KEY `index_cities_on_country_id` (`country_id`),
  KEY `index_cities_on_name` (`name`),
  KEY `index_cities_on_name_and_country_id_and_region_id` (`name`,`country_id`,`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `referer` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent_id` int(11) NOT NULL DEFAULT '1',
  `short_url_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `located` tinyint(1) DEFAULT '0',
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `like_it_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_clicks_on_short_url_id` (`short_url_id`),
  KEY `index_clicks_on_user_agent_id` (`user_agent_id`),
  KEY `index_clicks_on_short_url_id_and_created_at` (`short_url_id`,`created_at`),
  KEY `index_clicks_on_like_it_id` (`like_it_id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `display` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_countries_on_name` (`name`),
  KEY `index_countries_on_code` (`code`),
  KEY `index_countries_on_name_and_code` (`name`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `dashboard_tails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `attachable_id` int(11) DEFAULT NULL,
  `attachable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transition` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transition_user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_dashboard_tails_on_account_id` (`account_id`),
  KEY `index_dashboard_tails_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `invites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `like_its` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile_campaign_id` int(11) DEFAULT NULL,
  `clicks_count` int(11) DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_like_its_on_mobile_campaign_id` (`mobile_campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `mobile_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `style_model` text COLLATE utf8_unicode_ci,
  `document_model` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `current_state` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'draft',
  `short_url_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mobile_campaigns_on_current_state` (`current_state`),
  KEY `index_mobile_campaigns_on_account_id` (`account_id`),
  KEY `index_mobile_campaigns_on_short_url_id` (`short_url_id`),
  KEY `index_mobile_campaigns_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `mobiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resolution` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `width` int(11) DEFAULT '0',
  `height` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3979 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_regions_on_code` (`code`),
  KEY `index_regions_on_name` (`name`),
  KEY `index_regions_on_country_id` (`country_id`),
  KEY `index_regions_on_code_and_country_id` (`code`,`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `short_sequences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `short_urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `short` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `clicks_count` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `current_state` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'proxied',
  `account_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `short` (`short`),
  UNIQUE KEY `short_2` (`short`),
  UNIQUE KEY `short_3` (`short`),
  KEY `index_short_urls_on_current_state` (`current_state`),
  KEY `index_short_urls_on_account_id` (`account_id`),
  KEY `index_short_urls_on_user_id` (`user_id`),
  KEY `index_short_urls_on_short` (`short`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `summarized_clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clicks` int(11) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `short_url_id` int(11) NOT NULL,
  `percent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_summarized_clicks_on_short_url_id` (`short_url_id`),
  KEY `index_summarized_clicks_on_short_url_id_and_date` (`short_url_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `user_agents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `details` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `profile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `x_wap_profile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_agents_on_mobile_id` (`mobile_id`),
  KEY `index_user_agents_on_details` (`details`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `crypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `persistence_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `single_access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `perishable_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `failed_login_count` int(11) NOT NULL DEFAULT '0',
  `last_request_at` datetime DEFAULT NULL,
  `current_login_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `current_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20100430172227');

INSERT INTO schema_migrations (version) VALUES ('20100501201745');

INSERT INTO schema_migrations (version) VALUES ('20100503140340');

INSERT INTO schema_migrations (version) VALUES ('20100503141450');

INSERT INTO schema_migrations (version) VALUES ('20100504172103');

INSERT INTO schema_migrations (version) VALUES ('20100512175856');

INSERT INTO schema_migrations (version) VALUES ('20100517165032');

INSERT INTO schema_migrations (version) VALUES ('20100628161310');

INSERT INTO schema_migrations (version) VALUES ('20100903092532');

INSERT INTO schema_migrations (version) VALUES ('20100923145735');

INSERT INTO schema_migrations (version) VALUES ('20100923150606');

INSERT INTO schema_migrations (version) VALUES ('20101005090024');

INSERT INTO schema_migrations (version) VALUES ('20101117164536');

INSERT INTO schema_migrations (version) VALUES ('20101122194643');

INSERT INTO schema_migrations (version) VALUES ('20101122204544');

INSERT INTO schema_migrations (version) VALUES ('20101122221155');

INSERT INTO schema_migrations (version) VALUES ('20101124155451');

INSERT INTO schema_migrations (version) VALUES ('20101130155522');

INSERT INTO schema_migrations (version) VALUES ('20101201085957');

INSERT INTO schema_migrations (version) VALUES ('20101207162958');

INSERT INTO schema_migrations (version) VALUES ('20101207172929');

INSERT INTO schema_migrations (version) VALUES ('20101208140500');

INSERT INTO schema_migrations (version) VALUES ('20101208185144');

INSERT INTO schema_migrations (version) VALUES ('20101208194411');

INSERT INTO schema_migrations (version) VALUES ('20101208200117');

INSERT INTO schema_migrations (version) VALUES ('20101216112014');

INSERT INTO schema_migrations (version) VALUES ('20101222102300');

INSERT INTO schema_migrations (version) VALUES ('20101225160717');

INSERT INTO schema_migrations (version) VALUES ('20101227143118');

INSERT INTO schema_migrations (version) VALUES ('20110121125656');

INSERT INTO schema_migrations (version) VALUES ('20110122112902');

INSERT INTO schema_migrations (version) VALUES ('20110127131557');

INSERT INTO schema_migrations (version) VALUES ('20110128115153');

INSERT INTO schema_migrations (version) VALUES ('20110210154821');

INSERT INTO schema_migrations (version) VALUES ('20110211110853');

INSERT INTO schema_migrations (version) VALUES ('20110216155843');

INSERT INTO schema_migrations (version) VALUES ('20110221184634');

INSERT INTO schema_migrations (version) VALUES ('20110222132101');

INSERT INTO schema_migrations (version) VALUES ('20110301191227');

INSERT INTO schema_migrations (version) VALUES ('20110301214721');

INSERT INTO schema_migrations (version) VALUES ('20110303130507');

INSERT INTO schema_migrations (version) VALUES ('20110317111022');

INSERT INTO schema_migrations (version) VALUES ('20110318151323');

INSERT INTO schema_migrations (version) VALUES ('20110318162756');